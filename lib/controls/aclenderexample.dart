import 'package:flutter/material.dart';

class aclenderexample extends StatefulWidget {
  const aclenderexample({super.key});

  @override
  State<aclenderexample> createState() => _aclenderexampleState();
}

class _aclenderexampleState extends State<aclenderexample> {
  DateTime? data;
  Future<void> pickData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: data ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (!mounted || picked == null) return;
    setState(() => data = picked);
  }

  void setDateValue() {
    setState(() {
      data = DateTime(2024, 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = data == null
        ? "No Date"
        : "${data!.day}/${data!.month}/${data!.year}";
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(onPressed: pickData, child: const Text('Pick Date')),
            ElevatedButton(
              onPressed: setDateValue,
              child: const Text('Set Date to 01/01/2024'),
            ),
          ],
        ),
      ),
    );
  }
}
