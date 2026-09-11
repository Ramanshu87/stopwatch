import 'package:flutter/material.dart';
import 'package:flutter_application/controls/inputtextcontrol.dart';
import 'package:flutter_application/stopwatch/login.dart';
import 'package:flutter_application/stopwatch/stopwatch.dart';
import 'controls/radiobutton.dart';
import 'controls/chkbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ChkBoxExam(),
      debugShowCheckedModeBanner: false,
    );
  }
}
