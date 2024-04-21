import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcaller/constants/colors.dart';
import 'package:gcaller/onboarding/permission.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 72),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 42,
                      height: 42,

                      child: Image.asset('assets/images/Vector.png'),
                      // Assuming the actual Image widget will replace the Container for logo
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'GCaller',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Get rewards for identifying spam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 200),
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PermissionScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B64FF),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 64, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
