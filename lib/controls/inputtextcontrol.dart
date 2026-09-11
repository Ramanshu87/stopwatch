import 'package:flutter/material.dart';

class ControlInput extends StatefulWidget {
  const ControlInput({super.key});

  @override
  State<ControlInput> createState() => _ControlInputState();
}

class _ControlInputState extends State<ControlInput> {
  final textController = TextEditingController();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void setTextValue() {
    setState(() {
      textController.text = 'Hello World';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),
            Text('Read:${textController.text}'),
            ElevatedButton(
              onPressed: setTextValue,
              child: const Text('Set Text'),
            ),
          ],
        ),
      ),
    );
  }
}
