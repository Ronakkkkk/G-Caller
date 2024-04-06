import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:gcaller/widgets/bottom_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _requestPermissions() async {
    final PermissionStatus permissionStatus =
        await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      _getContacts();
    } else {
      print('Permission denied');
    }
  }

  Future<void> _getContacts() async {
    if (await Permission.contacts.isGranted) {
      final List<Contact> contacts = await FlutterContacts.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } else {
      _requestPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedindex = 0;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedindex,
          onItemSelected: (index) {
            setState(() {
              _selectedindex = index;
            });
          }),
      appBar: AppBar(
        title: Text('Contacts'),
        automaticallyImplyLeading: false,
      ),
      body: _contacts.isNotEmpty
          ? ListView.separated(
              itemCount: _contacts.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                final phoneNumbers =
                    contact.phones.map((phone) => phone.number).toList();
                final phoneText = phoneNumbers.isNotEmpty
                    ? phoneNumbers.join(', ')
                    : 'No phone number';
                return ListTile(
                  title: Text(contact.displayName ?? ''),
                  subtitle: Text(contact.id),
                  // You can display more information about the contact if needed
                );
              },
            )
          : Center(
              child: Text('No contacts'),
            ),
    );
  }
}
