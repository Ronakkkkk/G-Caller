import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:gcaller/widgets/contact_stream.dart';
import 'package:gcaller/widgets/overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

class Calldetectpage extends StatefulWidget {
  const Calldetectpage({Key? key}) : super(key: key);

  @override
  State<Calldetectpage> createState() => _CalldetectpageState();
}

class _CalldetectpageState extends State<Calldetectpage> {
  PhoneState status = PhoneState.nothing();

  @override
  void initState() {
    super.initState();
    checkPermissionAndSetStream();
  }

  Future<void> checkPermissionAndSetStream() async {
    var permissionStatus = await Permission.phone.status;
    if (permissionStatus.isDenied ||
        permissionStatus.isRestricted ||
        permissionStatus.isLimited ||
        permissionStatus.isPermanentlyDenied) {
      // Request permission if not granted
      await requestPermission();
    } else if (permissionStatus.isGranted) {
      // Set up stream if permission is already granted
      setStream();
    }
  }

  Future<void> requestPermission() async {
    var status = await Permission.phone.request();
    if (status.isGranted) {
      setStream();
    }
  }

  void setStream() {
    PhoneState.stream.listen((event) {
      setState(() {
        status = event;
        print('Call status: ${status.status}');
        if (status.status == PhoneStateStatus.CALL_INCOMING &&
            status.number != null) {
          print('Incoming call detected: ${status.number}');
          //ContactStream.addCallerNumber(status.number ?? 'Unknown');
          _showOverlay(
              status.number); // Show overlay when incoming call detected
        }
      });
    }, onError: (error) {
      print('Error in phone state stream: $error');
    });
  }

  Future<String?> getContactName(String? phoneNumber) async {
    try {
      if (phoneNumber != null) {
        // Remove non-numeric characters from the incoming call number
        var normalizedPhoneNumber =
            phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

        // Remove leading "977" country code if present
        if (normalizedPhoneNumber.startsWith('977')) {
          normalizedPhoneNumber = normalizedPhoneNumber.substring(3);
        }

        if (normalizedPhoneNumber.startsWith('91')) {
          normalizedPhoneNumber = normalizedPhoneNumber.substring(2);
        }

        if (normalizedPhoneNumber.startsWith('01')) {
          normalizedPhoneNumber = normalizedPhoneNumber.substring(2);
        }

        // Fetch all contacts with full information
        final List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true,
        );

        // Iterate through contacts to find a match
        for (final Contact contact in contacts) {
          for (final Phone phone in contact.phones ?? []) {
            // Normalize the contact number by removing non-numeric characters
            var normalizedContactNumber =
                phone.number!.replaceAll(RegExp(r'[^\d]'), '');

            // Remove leading "977" country code if present
            if (normalizedContactNumber.startsWith('977')) {
              normalizedContactNumber = normalizedContactNumber.substring(3);
            }

            if (normalizedContactNumber.startsWith('91')) {
              normalizedContactNumber = normalizedContactNumber.substring(2);
            }

            if (normalizedContactNumber.startsWith('01')) {
              normalizedContactNumber = normalizedContactNumber.substring(2);
            }

            // Compare the normalized numbers
            if (normalizedContactNumber == normalizedPhoneNumber) {
              return contact.displayName;
            }
          }
        }
      }
    } catch (e) {
      print('Error retrieving contact name: $e');
      return null;
    }
    return null; // Return null if contact name not found
  }

  void _showOverlay(String? callerNumber) async {
    String? contactName = await getContactName(callerNumber);

    // Show overlay
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      overlayTitle: "GCALLER",
      overlayContent: '$callerNumber is calling', // Notification message
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: (MediaQuery.of(context).size.height * 0.6).toInt(),
      width: WindowSize.matchParent,
      startPosition: const OverlayPosition(0, 0),
    );

    await FlutterOverlayWindow.shareData({
      'callerNumber': callerNumber,
      'contactName': contactName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone State'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Status of call',
              style: TextStyle(fontSize: 24),
            ),
            if (status.status == PhoneStateStatus.CALL_STARTED)
              Text(
                'Number: ${status.number}',
                style: const TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
