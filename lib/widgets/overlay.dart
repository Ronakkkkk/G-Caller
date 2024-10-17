import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:gcaller/widgets/contact_stream.dart';

class TrueCallerOverlay extends StatefulWidget {
  const TrueCallerOverlay({
    Key? key,
  }) : super(key: key);

  @override
  State<TrueCallerOverlay> createState() => _TrueCallerOverlayState();
}

Widget contactInitialIcon(String? contactName, bool isredoverlay) {
  String initial =
      contactName?.isNotEmpty == true ? contactName![0].toUpperCase() : 'U';
  return Container(
    margin: const EdgeInsets.only(left: 20),
    height: 70.0,
    width: 70.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(isredoverlay ? 0xffBEE3DC : 0xffBEE3DC)),
    child: Center(
      child: isredoverlay
          ? const Icon(
              Icons.security_outlined,
              size: 40,
              color: Color(0xffFE4433),
            )
          : Text(
              initial,
              style: const TextStyle(fontSize: 40, color: Color(0xff349484)),
            ),
    ),
  );
}

class _TrueCallerOverlayState extends State<TrueCallerOverlay> {
  String? callerNumber;
  String? contactName;

  @override
  void initState() {
    super.initState();
    // Listen for data shared from the main app
    FlutterOverlayWindow.overlayListener.listen((data) {
      setState(() {
        callerNumber = data['callerNumber'];
        contactName = data['contactName'];
      });
      print('$contactName:$callerNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if callerNumber matches specific numbers
    bool isRedOverlay = callerNumber == '9818383799'; // Example spam number

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: isRedOverlay
                ? const Color(0xffFF4130)
                : const Color(0xff0086FF),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        contactInitialIcon(
                            contactName, isRedOverlay ? true : false),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display contact name
                            Text(
                              isRedOverlay
                                  ? 'Spam Caller'
                                  : contactName ?? 'Unknown Caller',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat"),
                            ),
                            Text(
                              isRedOverlay
                                  ? 'SALES . 450 spam reports'
                                  : 'Banglore, India',
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
                                  isRedOverlay
                                      ? 'Finance / Insurance'
                                      : 'From Contacts',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display contact number
                              Text(
                                callerNumber ?? '00000000',
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 11,
                                    color: Colors.white),
                              ),
                              Text(
                                "Mobile - AirTel - Last call 0 min ago",
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
