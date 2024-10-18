import 'package:flutter/material.dart';
import 'package:gcaller/utils/okto.dart';

class OktoWalletFlutter extends StatefulWidget {
  const OktoWalletFlutter({super.key});

  @override
  State<OktoWalletFlutter> createState() => _OktoWalletFlutter();
}

class _OktoWalletFlutter extends State<OktoWalletFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              await okto?.openBottomSheet(context: context);
            },
            child: const Text('open bottomSheet')),
      ),
    );
  }
}
