import 'package:flutter/material.dart';
import 'package:flutter_application/controls/dropdown.dart';
import 'package:flutter_application/controls/gridview.dart';
import 'package:flutter_application/controls/imagedisplay.dart';
import 'package:flutter_application/controls/inputtextcontrol.dart';
import 'package:flutter_application/controls/scrollviewimage.dart';
import 'package:flutter_application/controls/sliderexample.dart';
import 'package:flutter_application/controls/tabview.dart';
import 'package:flutter_application/register/register.dart';
import 'package:flutter_application/stopwatch/login.dart';
import 'package:flutter_application/stopwatch/stopwatch.dart';
import 'package:flutter_application/controls/aclenderexample.dart';
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
    return MaterialApp(home: Registration(), debugShowCheckedModeBanner: false);
  }
}
