import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:gcaller/firebase_options.dart';
import 'package:gcaller/onboarding/rewardsplashscreen.dart';
import 'package:gcaller/onboarding/signin.dart';
import 'package:gcaller/onboarding/welcome.dart';
import 'package:gcaller/screens/contact.dart';
import 'package:gcaller/views/phone_state_listener.dart';
import 'package:gcaller/widgets/contact_stream.dart';
import 'package:gcaller/widgets/overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!await FlutterOverlayWindow.isPermissionGranted()) {
    FlutterOverlayWindow.requestPermission();
  }

  // Check if the user is already signed in
  User? user = FirebaseAuth.instance.currentUser;
  Widget initialRoute = user != null ? ContactScreen() : WelcomeScreen();
  ;
  PhoneStateListener().initialize();
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gcaller',
      home: initialRoute,
    );
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
