import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:gcaller/onboarding/rewardsplashscreen.dart';
import 'package:gcaller/screens/profile.dart';
import 'package:gcaller/widgets/overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!await FlutterOverlayWindow.isPermissionGranted()) {
    FlutterOverlayWindow.requestPermission();
  }
  runApp(MyApp());
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
        home: RewardSplash());
  }
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TrueCallerOverlay(),
  ));
}
