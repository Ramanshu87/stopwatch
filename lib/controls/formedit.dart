import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/controls/formlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Map<String, dynamic>> items = [];

  static const _key = 'entries';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pref = await SharedPreferences.getInstance();

    final raw = pref.getString(_key);

    if (raw == null) return;

    final list = jsonDecode(raw) as List;

    setState(() {
      items = list.cast<Map<String, dynamic>>();
    });
  }

  // DELETE
  Future<void> _delete(int index) async {
    items.removeAt(index);

    final pref = await SharedPreferences.getInstance();

    await pref.setString(_key, jsonEncode(items));

    setState(() {});
  }

  // UPDATE
  void _update(int index) {
    final item = items[index];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormList(),
        settings: RouteSettings(
          arguments: {
            'index': index,
            'name': item['name'],
            'gender': item['gender'],
            'agree': item['agree'],
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Data')),

      body: ListView.builder(
        itemCount: items.length,

        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            child: ListTile(
              title: Text(item['name']),

              subtitle: Text(
                'Gender: ${item['gender']} | '
                'Agree: ${item['agree']}',
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  // UPDATE BUTTON
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _update(index);
                    },
                  ),

                  // DELETE BUTTON
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _delete(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
