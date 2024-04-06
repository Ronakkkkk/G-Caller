import 'package:flutter/material.dart';
import 'package:gcaller/constants/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: Color(0xffEDA9EA),
              ),
              Positioned(
                bottom: -50,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFFAEE8),
                    border: Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
