import 'package:flutter/material.dart';

class MainprofileScreen extends StatelessWidget {
  const MainprofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              color: Colors.red,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 1,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
