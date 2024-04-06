import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/bottom_navigation_bar.dart';

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({Key? key}) : super(key: key);

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  int _selectedIndex = 0;
  List<CallLogEntry> _callLogs = [];

  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  Future<void> _requestPermissions() async {
    final PermissionStatus permissionStatus = await Permission.phone.request();
    if (permissionStatus.isGranted) {
      _getCallLogs();
    } else {
      print('Permission denied');
    }
  }

  Future<void> _getCallLogs() async {
    if (await Permission.phone.isGranted) {
      final Iterable<CallLogEntry> callLogs = await CallLog.get();
      setState(() {
        _callLogs = callLogs.toList();
      });
    } else {
      _requestPermissions();
    }
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
      appBar: AppBar(
        title: Text('Call Logs'),
      ),
      body: _callLogs.isNotEmpty
          ? ListView.separated(
              itemCount: _callLogs.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final callLog = _callLogs[index];
                return ListTile(
                  title: Text(callLog.name ?? 'Unknown'),
                  subtitle: Text(callLog.number.toString()),
                  trailing: Text(callLog.timestamp.toString()),
                  // You can display more information about the call log if needed
                );
              },
            )
          : Center(
              child: Text('No call logs'),
            ),
    );
  }
}
