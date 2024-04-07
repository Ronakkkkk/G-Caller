import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcaller/onboarding/rewardsplashscreen.dart';
import 'package:gcaller/screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!await FlutterOverlayWindows.isPermissionGranted()) runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gcaller',
        home: ProfileScreen());
  }
}
