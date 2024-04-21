import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:gcaller/constants/colors.dart';
import 'package:gcaller/onboarding/authentication_logic.dart';
import 'package:gcaller/onboarding/rewardsplashscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    if (_nameController.text.isEmpty || _numberController.text.isEmpty) {
      _showSnackBar('Please enter your name and number.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // User is already signed in, navigate to RewardSplash directly
        _navigateToRewardSplash();
        return;
      }

      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final String? idToken = await userCredential.user!.getIdToken();

        print(idToken);

        if (idToken != null) {
          await ApiHandler.authenticateWithToken(idToken);
          await _writeDataToFirestore(context);

          _navigateToRewardSplash();
        } else {
          print("ID Token is null");
        }
      }
    } catch (error) {
      print("Something went wrong. Please try again");
      print(error);
      _showSnackBar('Something went wrong. Please try again');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToRewardSplash() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RewardSplash()),
    );
    print('navigating now!');
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
                          text: 'Sign in with Google',
                          onPressed: _handleGoogleSignIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
