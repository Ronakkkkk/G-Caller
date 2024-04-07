import 'package:flutter/material.dart';
import 'package:gcaller/constants/colors.dart';
import 'package:gcaller/screens/contact.dart';
import 'package:gcaller/screens/profile.dart';
import 'package:gcaller/screens/rewardscreen.dart';
import 'package:gcaller/screens/calllog.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  BottomNavBar({required this.selectedIndex, required this.onItemSelected});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color(0xff1B64FF),
      unselectedItemColor: kPrimaryColor,
      showUnselectedLabels: true,
      currentIndex: widget.selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactScreen()));
            break;
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CallLogScreen()));
            break;

          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Reward()));
            break;
          case 3:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: 'Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Calls',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Rewards',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
