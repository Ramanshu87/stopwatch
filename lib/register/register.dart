import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Registration()));
}

// ================= REGISTRATION =================

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // Controllers
  TextEditingController participant = TextEditingController();

  // State variables
  String department = "IT";
  String event = "Coding Challenge";
  bool tech = false;
  bool nonTech = false;
  DateTime? eventDate;
  double fees = 100;

  List<String> events = ["Coding Challenge", "Robo Race"];

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          eventDate = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void register() {
    if (participant.text.isEmpty || eventDate == null || (!tech && !nonTech)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please complete all fields")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventTabs(
          participant: participant.text,
          department: department,
          event: event,
          type: tech ? "Tech" : "Non-Tech",
          date: eventDate!,
          fees: fees,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TechFest Registration")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: participant,
            decoration: InputDecoration(
              labelText: "Participant Name",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 15),

          Text("Department"),
          Row(
            children: [
              Radio(
                value: "IT",
                groupValue: department,
                onChanged: (v) {
                  setState(() => department = v.toString());
                },
              ),
              Text("IT"),

              Radio(
                value: "CE",
                groupValue: department,
                onChanged: (v) {
                  setState(() => department = v.toString());
                },
              ),
              Text("CE"),

              Radio(
                value: "ME",
                groupValue: department,
                onChanged: (v) {
                  setState(() => department = v.toString());
                },
              ),
              Text("ME"),
            ],
          ),

          Text("Event Type"),

          CheckboxListTile(
            title: Text("Tech"),
            value: tech,
            onChanged: (v) {
              setState(() => tech = v!);
            },
          ),

          CheckboxListTile(
            title: Text("Non-Tech"),
            value: nonTech,
            onChanged: (v) {
              setState(() => nonTech = v!);
            },
          ),

          DropdownButtonFormField(
            value: event,
            decoration: InputDecoration(
              labelText: "Event Name",
              border: OutlineInputBorder(),
            ),
            items: events.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (v) {
              setState(() => event = v.toString());
            },
          ),

          SizedBox(height: 15),

          ElevatedButton(
            onPressed: pickDate,
            child: Text(
              eventDate == null
                  ? "Select Event Date & Time"
                  : eventDate.toString(),
            ),
          ),

          SizedBox(height: 10),

          Text("Fees: ₹${fees.toInt()}"),

          Slider(
            min: 100,
            max: 1000,
            divisions: 9,
            value: fees,
            onChanged: (v) {
              setState(() => fees = v);
            },
          ),

          SizedBox(height: 20),

          ElevatedButton(onPressed: register, child: Text("REGISTER")),
        ],
      ),
    );
  }
}

// ================= TABS =================

class EventTabs extends StatelessWidget {
  final String participant;
  final String department;
  final String event;
  final String type;
  final DateTime date;
  final double fees;

  EventTabs({
    required this.participant,
    required this.department,
    required this.event,
    required this.type,
    required this.date,
    required this.fees,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TechFest"),
          bottom: TabBar(
            tabs: [
              Tab(text: "All Events"),
              Tab(text: "Event 1"),
              Tab(text: "Event 2"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // TAB 1
            GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: [eventCard("Coding Challenge"), eventCard("Robo Race")],
            ),

            // TAB 2
            eventDetails(
              "Coding Challenge",
              "Solve programming problems and complete "
                  "with other participants.",
            ),

            // TAB 3
            eventDetails(
              "Robo Race",
              "Build and control your robot to complete "
                  "the race as quickly as possible.",
            ),
          ],
        ),
      ),
    );
  }

  Widget eventCard(String name) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.computer, size: 60),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget eventDetails(String title, String description) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal scrolling images
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                eventImage(Icons.computer),
                eventImage(Icons.code),
                eventImage(Icons.emoji_events),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 15),

                Text(description, style: TextStyle(fontSize: 17)),

                SizedBox(height: 20),

                Text("Participant: $participant"),
                Text("Department: $department"),
                Text("Type: $type"),
                Text("Fees: ₹${fees.toInt()}"),
                Text("Date: $date"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget eventImage(IconData icon) {
    return Container(
      width: 250,
      margin: EdgeInsets.all(8),
      color: Colors.blue.shade100,
      child: Icon(icon, size: 100),
    );
  }
}
