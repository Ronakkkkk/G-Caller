import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:gcaller/constants/colors.dart';
import 'package:gcaller/widgets/bottom_navigation_bar.dart';
import 'package:neopop/neopop.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Widget button() {
  return Container(
    child: Row(
      children: [
        Container(
          width: 113,
          height: 36,
          color: const Color(0xffFFCE85),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Deposit",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff293B57),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.add,
                  color: kPrimaryColor,
                  size: 15,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 113,
          height: 36,
          color: const Color(0xffF0F2F5),
          child: const Padding(
            padding: EdgeInsets.only(top: 6, bottom: 6, left: 15, right: 10),
            child: Row(
              children: [
                Text(
                  "Withdraw",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff293B57),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_downward,
                  color: kPrimaryColor,
                  size: 15,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackground,
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  if (await FlutterOverlayWindow.isActive()) return;
                  await FlutterOverlayWindow.showOverlay(
                    enableDrag: true,
                    overlayTitle: "GCALLER",
                    overlayContent: 'Spam Business Detected',
                    flag: OverlayFlag.defaultFlag,
                    visibility: NotificationVisibility.visibilityPublic,
                    positionGravity: PositionGravity.auto,
                    height: (MediaQuery.of(context).size.height * 0.6).toInt(),
                    width: WindowSize.matchParent,
                    startPosition: const OverlayPosition(0, 0),
                  );
                },
                child: Container(
                    color: const Color(0xffEDA9EA),
                    height: 255,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(flex: 2, child: Container()),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: kBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 45,
                              right: 15,
                              left: 15,
                            ),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffFFAEE8),
                              border: Border.all(
                                color: Colors.white,
                                width: 8.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14, left: 14),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 331,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'John Singh',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.edit_outlined,
                                  size: 19,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '4Uj3Enms................m1toot',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.copy,
                                  size: 19,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Center(
                            child: Text(
                              'User since April 01, 2024',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: Color(0xffB2B8C2),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 310,
                      width: 331,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Your Balance',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff293B57),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.wallet,
                                color: Color(0xffFFC977),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '700 GCAL',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff293B57),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Text(
                                '+ 500 GCALL',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff293B57)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Welcome Bonus',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffB2B8C2)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Text(
                                '+ 200 GCALL',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff293B57)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Imported 40 Contacts',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffB2B8C2)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          button(),
                          const SizedBox(
                            height: 15,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Get more points',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffB2B8C2)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                size: 19,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Get 10 GCALL for each new contact',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '22 New Found',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff2FD786)),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
