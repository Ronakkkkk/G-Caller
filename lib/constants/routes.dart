import 'package:flutter/material.dart';
import 'package:gcaller/screens/contact.dart';
import 'package:gcaller/screens/rewardscreen.dart';
import 'package:gcaller/screens/calllog.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      '/': (context) => const ContactScreen(),
      '/calls': (context) => const CallLogScreen(),
      '/rewards': (context) => const Reward(),
    };
  }
}
