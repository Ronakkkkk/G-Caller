import 'package:flutter/material.dart';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:phone_state/phone_state.dart';

class PhoneStateListener {
  static final PhoneStateListener _instance = PhoneStateListener._internal();

  factory PhoneStateListener() {
    return _instance;
  }

  PhoneStateListener._internal();

  void initialize() {
    PhoneState.stream.listen((event) {
      if (event.status == PhoneStateStatus.CALL_INCOMING &&
          event.number != null) {
        _showOverlay(event.number!);
      }
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
      height: 500,
      width: WindowSize.matchParent,
      startPosition: const OverlayPosition(0, 0),
    );

    await FlutterOverlayWindow.shareData({
      'callerNumber': callerNumber,
      'contactName': contactName,
    });
  }
}
