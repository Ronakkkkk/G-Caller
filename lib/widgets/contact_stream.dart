import 'dart:async';

import 'package:flutter_contacts/contact.dart';

class ContactStream {
  static final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>.broadcast();

  static Stream<Map<String, dynamic>> get stream => _controller.stream;

  static void addContact(Contact contact) {
    final Map<String, dynamic> contactData = {
      'type': 'contact',
      'displayName': contact.displayName,
      'phones': contact.phones.map((phone) => phone.number).toList(),
      // Add more fields as needed
    };
    _controller.add(contactData);
  }

  static void addCallerNumber(String phoneNumber) {
    _controller.add({'phoneNumber': phoneNumber});
  }

  static void dispose() {
    _controller.close();
  }
}
