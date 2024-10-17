import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gcaller/constants/colors.dart';

import 'package:gcaller/widgets/bottom_navigation_bar.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  int _selectedIndex = 2;
  int newContactsCount = 0;
  int existingContactsCount = 0;
  int totalPoints = 0;
  Widget buildTickRow(String text1, String text2, String text3) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.check),
            Text(
              text1,
              style: const TextStyle(
                color: Color(0xff068D34),
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: Color(0xff293B57), // Set your desired color here
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            text3,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Color(0xff293B57), // Set your desired color here
            ),
          ),
        )
      ],
    );
  }

  Future<void> fetchData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('Users')
            .doc(user.uid)
            .get();

        setState(() {
          newContactsCount = userDoc['newContactsCount'] ?? 0;
          existingContactsCount = userDoc['existingContactsCount'] ?? 0;
          totalPoints = userDoc['gcallamount'] ?? 0;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/gift.png')),
                const Text(
                  'Your current points!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff293B57)),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 98,
                  width: 292,
                  decoration: BoxDecoration(
                    color: Color(0xffFCE5C3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$totalPoints',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'GCALL',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 183,
                  width: 312,
                  color: const Color(0xffFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildTickRow('+500 \$GCALL', " welcome bonus", ""),
                      buildTickRow('+ ${newContactsCount * 5}  \$GCALL ',
                          "for tagging every ", "new contact"),
                      SizedBox(
                        height: 10,
                      ),
                      buildTickRow(
                          '+${existingContactsCount * 1}  \$GCALL',
                          "for importing each ",
                          "existing contact into GCall App"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
