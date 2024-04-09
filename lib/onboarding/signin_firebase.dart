import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gcaller/constants/colors.dart';
import 'package:gcaller/onboarding/rewardsplashscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Signinfirebase extends StatefulWidget {
  const Signinfirebase({Key? key}) : super(key: key);

  @override
  State<Signinfirebase> createState() => _SigninfirebaseState();
}

class _SigninfirebaseState extends State<Signinfirebase> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    if (_nameController.text.isEmpty || _numberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your name and number.'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      final UserCredential userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);

      if (userCredential.user != null) {
        await _writeDataToFirestore(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RewardSplash()),
        );
      } else {
        print('User credential is null.');
      }
    } catch (error) {
      print('Error during sign in: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _writeDataToFirestore(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Collect contacts
        Iterable<Contact> contacts = await FlutterContacts.getContacts();

        // Fetch existing contacts from Firestore
        QuerySnapshot existingContacts =
            await FirebaseFirestore.instance.collection('Contacts').get();

        // Extract existing contact names
        Set<String> existingContactNames =
            Set<String>.from(existingContacts.docs.map((doc) => doc['name']));

        // Batch to perform batch writes
        WriteBatch batch = FirebaseFirestore.instance.batch();

        // Counters for new and existing contacts
        int newContactsCount = 0;
        int totalContactsCount = existingContacts.docs.length;

        // Iterate through contacts
        contacts.forEach((contact) {
          if (!existingContactNames.contains(contact.displayName)) {
            // Parse and format phone numbers
            List<String> formattedPhoneNumbers =
                _parsePhoneNumbers(contact.phones);

            // Add the contact to batch
            var newContactRef =
                FirebaseFirestore.instance.collection('Contacts').doc();
            batch.set(newContactRef, {
              'name': contact.displayName,
              'numbers': formattedPhoneNumbers,
            });

            // Increment the counter for new contacts
            newContactsCount++;
          }
        });

        // Commit the batch
        await batch.commit();

        // Update contacts count for the current user
        int existingContactsCount = totalContactsCount - newContactsCount;
        await updateContactsCount(newContactsCount, existingContactsCount);

        print('Contacts imported to Firestore successfully.');
        print('New contacts added: $newContactsCount');
      } else {
        print('User not authenticated.');
      }
    } catch (error) {
      print('Error writing to Firestore: $error');
    }
  }

  List<String> _parsePhoneNumbers(List<dynamic>? phones) {
    List<String> formattedPhoneNumbers = [];
    if (phones != null) {
      for (var phoneNumber in phones) {
        if (phoneNumber is String) {
          String formattedPhoneNumber =
              phoneNumber.replaceAll(RegExp(r'\D'), '');
          formattedPhoneNumbers.add(formattedPhoneNumber);
        }
      }
    }
    return formattedPhoneNumbers;
  }

  Future<void> updateContactsCount(
      int newContactsCount, int existingContactsCount) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'newContactsCount': newContactsCount,
          'existingContactsCount': existingContactsCount
        }, SetOptions(merge: true));

        print('Contacts count updated successfully.');
      } else {
        print('User not authenticated.');
      }
    } catch (error) {
      print('Error updating contacts count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 70),
                  child: const Row(
                    children: [
                      Text(
                        'Let\'s get your profile \nupto speed.',
                        style: TextStyle(
                            fontSize: 24,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your full name..',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kPrimaryColor,
                          fontFamily: "Montserrat"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your number..',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: kPrimaryColor,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: _isLoading
                      ? CircularProgressIndicator() // Show progress indicator
                      : SignInButton(Buttons.google,
                          text: 'Sign in with Google', onPressed: () {
                          _handleGoogleSignIn(context);
                        }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
