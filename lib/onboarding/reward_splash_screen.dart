import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
                height: 301,
                width: 301,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://s3-alpha-sig.figma.com/img/93d8/e723/afb0784d3b9dba31697049a81c75d9d4?Expires=1713139200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=RLwx9fQoWK5AX6jF30ZQtzwz2W19E~k6mJcU2-M7h033oZz6iwUEzu7NEVOB91OXKGX42PPnWzUZ6B-DEpRIWsryFwYg316Ye9398nqxDXM7cJTGnim2QUXSWGPDsMpfvryr~PbSCosf4Z7K5tS5Gz9T1GQNeP2nxH7qnp3t2UajDJckIeL5e7YCiKXIWcnJww310seAUh8lAFqclaKEsegAwYPEp~aOvmSQwvk5QHk2rOvX-xT~kDNs6XhhVAER-tK2RbpKK9aHGU2dmYxKUvFmLab83mBzCuzDRb4dziiYBh02OfblxPB-~hjYVhGxSHEwKoQ9fCllaEXILg44~Q__')),
            Text('Hello')
          ],
        ),
      ),
    );
  }
}
