import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcaller/constants/colors.dart';

import 'package:gcaller/onboarding/rewardsplashscreen.dart';
import 'package:gcaller/onboarding/signin.dart';
import 'package:gcaller/onboarding/signin_firebase.dart';
import 'package:permission_handler/permission_handler.dart';

class InfoItem extends StatelessWidget {
  final IconData? icon;
  final String? text;

  const InfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 35,
            margin: const EdgeInsets.only(right: 16),
            child: Icon(icon),
          ),
          Text(text ?? ''),
        ],
      ),
    );
  }
}

class PermissionScreen extends StatelessWidget {
  final data = [
    {
      'key': '1',
      'icon': Icons.safety_check_outlined,
      'text': 'We never sell your data',
    },
    {
      'key': '2',
      'icon': Icons.perm_identity_sharp,
      'text': 'We only ask for essential Permissions',
    },
    {
      'key': '3',
      'icon': Icons.wallet_giftcard_outlined,
      'text': 'You get rewarded for identifying spam',
    },
  ];

  Future<void> _requestPermissions(BuildContext context) async {
    final contactsStatus = await Permission.contacts.request();
    final callLogStatus = await Permission.phone.request();

    if (contactsStatus.isGranted && callLogStatus.isGranted) {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => SignInScreen())));
      print('Permissions granted');
    } else {
      // Permissions not granted, handle accordingly
      print('Permissions not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              'You are important, \nso is your data.',
              style: TextStyle(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"),
            ),
            const SizedBox(height: 80),
            ...data
                .map((item) => InfoItem(
                      icon: item['icon'] as IconData?,
                      text: item['text'] as String?,
                    ))
                .toList(),
            const SizedBox(height: 176),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  _requestPermissions(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text(
                  'Agree & Continue',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
