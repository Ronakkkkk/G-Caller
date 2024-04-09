import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gcaller/constants/colors.dart';
import 'package:gcaller/screens/contact.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class RewardSplash extends StatefulWidget {
  const RewardSplash({Key? key}) : super(key: key);

  @override
  _RewardSplashState createState() => _RewardSplashState();
}

class _RewardSplashState extends State<RewardSplash> {
  int newContactsCount = 0;
  int existingContactsCount = 0;
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    fetchContactsCounts();
  }

  Future<void> fetchContactsCounts() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('Users')
            .doc(user.uid)
            .get();

        // Check if the document exists
        if (userDoc.exists) {
          // Check if the fields exist within the document
          if (userDoc.data()!.containsKey('newContactsCount') &&
              userDoc.data()!.containsKey('existingContactsCount')) {
            setState(() {
              newContactsCount = userDoc['newContactsCount'] ?? 0;
              existingContactsCount = userDoc['existingContactsCount'] ?? 0;
              totalPoints =
                  500 + (newContactsCount * 5) + existingContactsCount;
            });

            // Update the user document with the total points
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .update({'gcallamount': totalPoints});
          } else {
            print('Missing fields in the document.');
          }
        } else {
          print('Document does not exist.');
        }
      }
    } catch (error) {
      print('Error fetching contacts counts: $error');
    }
  }

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
                color: Color(0xff293B57),
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
              color: Color(0xff293B57),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                height: 250,
                width: 250,
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://s3-alpha-sig.figma.com/img/93d8/e723/afb0784d3b9dba31697049a81c75d9d4?Expires=1713139200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=RLwx9fQoWK5AX6jF30ZQtzwz2W19E~k6mJcU2-M7h033oZz6iwUEzu7NEVOB91OXKGX42PPnWzUZ6B-DEpRIWsryFwYg316Ye9398nqxDXM7cJTGnim2QUXSWGPDsMpfvryr~PbSCosf4Z7K5tS5Gz9T1GQNeP2nxH7qnp3t2UajDJckIeL5e7YCiKXIWcnJww310seAUh8lAFqclaKEsegAwYPEp~aOvmSQwvk5QHk2rOvX-xT~kDNs6XhhVAER-tK2RbpKK9aHGU2dmYxKUvFmLab83mBzCuzDRb4dziiYBh02OfblxPB-~hjYVhGxSHEwKoQ9fCllaEXILg44~Q__',
                ),
              ),
              const Text(
                'Here is your welcome gift!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Color(0xff293B57),
                ),
              ),
              SizedBox(
                height: 20,
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
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 183,
                width: 312,
                color: const Color(0xffFFFFFF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildTickRow(
                      '+500 \$GCALL',
                      ' welcome bonus',
                      '',
                    ),
                    buildTickRow(
                      '+ ${newContactsCount * 5} \$GCALL ',
                      'for tagging $newContactsCount ',
                      'new contact',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTickRow(
                      '+${existingContactsCount * 1} \$GCALL',
                      'for importing $existingContactsCount ',
                      'existing contact into GCall App',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45, left: 14, right: 14),
                child: NeoPopButton(
                  buttonPosition: Position.bottomCenter,
                  color: const Color(0xff1B64FF),
                  onTapUp: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's get started!",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
