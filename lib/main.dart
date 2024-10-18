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
import 'package:gcaller/utils/okto.dart';
import 'package:gcaller/views/phone_state_listener.dart';
import 'package:gcaller/wallet/okto_wallet.dart';
import 'package:gcaller/wallet/view_wallet_page.dart';
import 'package:gcaller/widgets/contact_stream.dart';
import 'package:gcaller/widgets/overlay.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:gcaller/utils/global.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  Globals globals = Globals.instance;
  okto = Okto(globals.getOktoApiKey(), globals.getBuildType());

  // Print the API key for debugging (remove in production)
  print("Okto API Key: ${globals.getOktoApiKey()}");
  print("Build Type: ${globals.getBuildType()}");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!await FlutterOverlayWindow.isPermissionGranted()) {
    FlutterOverlayWindow.requestPermission();
  }

  // Check if the user is already signed in

  ;

  PhoneStateListener().initialize();
  runApp(MyApp(initialRoute: ContactScreen()));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  Future<bool> checkLoginStatus() async {
    return await okto!.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gcaller',
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            bool isLoggedIn = snapshot.data ?? false;
            if (isLoggedIn) {
              return ContactScreen();
            } else {
              return ViewWalletPage();
            }
          }
        },
      ),
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
