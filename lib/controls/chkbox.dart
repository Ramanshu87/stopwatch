import 'package:flutter/material.dart';
class ChkBoxExam extends StatefulWidget {
  const ChkBoxExam({super.key});

  @override
  State<ChkBoxExam> createState() => _ChkBoxExamState();
}

class _ChkBoxExamState extends State<ChkBoxExam> {
  bool ischecked = false;

  void updateChkBox(){
    setState(() {
      ischecked = !ischecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CheckboxListTile(
              title: const Text("Check Box"),
              value: ischecked,
              onChanged: (v) => setState(() {
                ischecked = v!;
              }),
            ),
            Text('Read ${ischecked ? 'Agree':'Disagree'}'),
            ElevatedButton(onPressed: updateChkBox, child: const Text('Agree/Disagree')
            ),
          ],
        ),
      ),
    );
  }
}