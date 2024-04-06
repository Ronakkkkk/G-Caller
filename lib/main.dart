import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcaller/onboarding/rewardsplashscreen.dart';


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
        debugShowCheckedModeBanner: false,
        title: 'Gcaller',
        home: RewardSplash());
  }
}
