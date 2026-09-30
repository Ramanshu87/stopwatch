import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormList extends StatefulWidget {
  const FormList({super.key});

  @override
  State<FormList> createState() => _FormListState();
}

class _FormListState extends State<FormList> {
  final nameCtrl = TextEditingController();
  String gender = 'M';
  bool agree = false;
  List<Map<String, dynamic>> items = [];
  static const _key = 'entries';

  int? editIndex;

  Future<void> _load() async {
    final pref = await SharedPreferences.getInstance();
    final raw = pref.getString(_key);
    if (raw == null) return;
    final list = jsonDecode(raw) as List;
    setState(() {
      items = list.cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _save() async {
    if (nameCtrl.text.trim().isEmpty) return;
    if (editIndex == null) {
      items.add({'name': nameCtrl.text, 'gender': gender, 'agree': agree});
    } else {
      items[editIndex!] = {
        'name': nameCtrl.text,
        'gender': gender,
        'agree': agree,
      };
    }
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_key, jsonEncode(items));

    nameCtrl.text = '';
    setState(() {
      gender = 'M';
      agree = false;
    });
  }

  void _update(int index) {
    final item = items[index];

    setState(() {
      nameCtrl.text = item['name'];
      gender = item['gender'];
      agree = item['agree'];
      editIndex = index;
    });
  }

  Future<void> _delete(int index) async {
    items.removeAt(index);
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_key, jsonEncode(items));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: 'Name'),
            ),

            RadioListTile<String>(
              title: Text('Male'),
              value: 'M',
              groupValue: gender,
              onChanged: (v) => setState(() => gender = v!),
            ),

            RadioListTile<String>(
              title: Text('Famale'),
              value: 'F',
              groupValue: gender,
              onChanged: (v) => setState(() => gender = v!),
            ),

            CheckboxListTile(
              title: Text('I agree'),
              value: agree,
              onChanged: (v) => setState(() => agree = v!),
            ),

            ElevatedButton(onPressed: _save, child: Text('Save')),
            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text(
                      'Gender: ${item['gender']} | Agree: ${item['agree']}',
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _update(index),
                        ),

                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _delete(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
