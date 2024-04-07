import 'package:flutter/material.dart';

import 'package:gcaller/widgets/bottom_navigation_bar.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  int _selectedIndex = 3;
  Widget buildTickRow(String text1, String text2, String text3) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.check),
            Text(
              text1,
              style: const TextStyle(
                color: Color(0xff068D34),
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: Color(0xff293B57), // Set your desired color here
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            text3,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Color(0xff293B57), // Set your desired color here
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                  height: 301,
                  width: 301,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://s3-alpha-sig.figma.com/img/93d8/e723/afb0784d3b9dba31697049a81c75d9d4?Expires=1713139200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=RLwx9fQoWK5AX6jF30ZQtzwz2W19E~k6mJcU2-M7h033oZz6iwUEzu7NEVOB91OXKGX42PPnWzUZ6B-DEpRIWsryFwYg316Ye9398nqxDXM7cJTGnim2QUXSWGPDsMpfvryr~PbSCosf4Z7K5tS5Gz9T1GQNeP2nxH7qnp3t2UajDJckIeL5e7YCiKXIWcnJww310seAUh8lAFqclaKEsegAwYPEp~aOvmSQwvk5QHk2rOvX-xT~kDNs6XhhVAER-tK2RbpKK9aHGU2dmYxKUvFmLab83mBzCuzDRb4dziiYBh02OfblxPB-~hjYVhGxSHEwKoQ9fCllaEXILg44~Q__')),
              const Text(
                'Here is your \n welcome gift!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff293B57)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 183,
                width: 312,
                color: const Color(0xffFFFFFF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildTickRow('+500 \$GCALL', " welcome bonus", ""),
                    buildTickRow(
                        '+ 10  \$GCALL ', "for tagging every ", "new contact"),
                    SizedBox(
                      height: 10,
                    ),
                    buildTickRow('+5  \$GCALL', "for importing each ",
                        "existing contact into GCall App"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
