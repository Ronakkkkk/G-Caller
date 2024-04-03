import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcaller/contact.dart';
import 'package:gcaller/mainprofilescreen.dart';
import 'package:gcaller/onboarding/reward_splash_screen.dart';
import 'package:gcaller/onboarding/test.dart';
import 'package:gcaller/src/calllog.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Gcaller', home: Hello());
  }
}
