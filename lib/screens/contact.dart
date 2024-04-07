import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:gcaller/constants/colors.dart';
import 'package:gcaller/widgets/bottom_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _selectedIndex = 0;
  List<Contact> _contacts = [];
  TextEditingController _searchController = TextEditingController();

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

  Widget _buildContactTile(Contact contact) {
    final phoneNumbers = contact.phones.map((phone) => phone.number).toList();
    final phoneText =
        phoneNumbers.isNotEmpty ? phoneNumbers.join(', ') : 'No phone number';
    return ListTile(
      leading: CircleAvatar(
        child: contact.photo != null
            ? Image.memory(contact.photo!)
            : Icon(Icons.person_outlined),
      ),
      title: Text(
        contact.displayName ?? '',
        style: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 16,
            color: kPrimaryColor,
            fontWeight: FontWeight.w500),
      ),
      onTap: () {
        // Define what happens when the tile is clicked
      },
    );
  }

  List<Widget> _buildContactList() {
    List<Widget> contactTiles = [];
    String? prevChar;

    _contacts.forEach((contact) {
      final firstChar = contact.displayName?[0].toUpperCase();
      if (prevChar != firstChar) {
        contactTiles.add(ListTile(
          title: Text(
            firstChar!,
            style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff1B72C0)),
          ),
          dense: true,
        ));
        prevChar = firstChar;
      }
      contactTiles.add(_buildContactTile(contact));
    });

    return contactTiles;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff1B64FF),
          onPressed: () {
            //Contacts add function
          },
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            margin: EdgeInsetsDirectional.only(top: 20),
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xffEFF1F8),
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search names, numbers...',
                hintStyle: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    color: Color(0xff74777F)),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: kPrimaryColor,
                ),
              ),
            ),
            Expanded(
              child: _contacts.isNotEmpty
                  ? ListView(
                      children: _buildContactList(),
                    )
                  : const Center(
                      child: Text('No contacts'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
