import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class TrueCallerOverlay extends StatefulWidget {
  const TrueCallerOverlay({Key? key}) : super(key: key);

  @override
  State<TrueCallerOverlay> createState() => _TrueCallerOverlayState();
}

Widget iconss() {
  return Container(
    margin: const EdgeInsets.only(left: 20),
    height: 70.0,
    width: 70.0,
    decoration:
        const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFDADA6)),
    child: const Icon(
      Icons.security_outlined,
      size: 40,
      color: Color(0xffFE4433),
    ),
  );
}

class _TrueCallerOverlayState extends State<TrueCallerOverlay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffFF4130),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                // ignore: prefer_const_constructors
                Column(
                  children: [
                    Row(
                      children: [
                        iconss(),
                        const SizedBox(
                          width: 15,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Spam Business",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat"),
                            ),
                            Text(
                              'SALES . 450 spam reports',
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.business,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Finance / Insurance',
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "+91 09230526844",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 11,
                                    color: Colors.white),
                              ),
                              Text(
                                "Attempted Last call 2 days ago",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 11,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            "GCALLER",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () async {
                      await FlutterOverlayWindow.closeOverlay();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
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
