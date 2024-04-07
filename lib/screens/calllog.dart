import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

import '../widgets/bottom_navigation_bar.dart';

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({Key? key}) : super(key: key);

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  int _selectedIndex = 1;
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

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) {
      return 'Unknown';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final callTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (callTime.isAtSameMomentAs(today)) {
      final formatter = DateFormat.jm(); // Show only time
      return 'Today ${formatter.format(callTime)}';
    } else if (callTime.isAtSameMomentAs(yesterday)) {
      return 'Yesterday';
    } else {
      final difference = now.difference(callTime);
      if (difference.inDays == 1) {
        return '1 day ago';
      } else {
        return '${difference.inDays} days ago';
      }
    }
  }

  Widget _buildCallLogTile(CallLogEntry callLog) {
    String callType = '';
    Color callTypeColor = Colors.green;
    late IconData callTypeIcon;

    if (callLog.callType == CallType.incoming) {
      callType = 'Incoming';
      callTypeColor = Colors.blue;
      callTypeIcon = Icons.call_received_outlined;
    } else if (callLog.callType == CallType.missed) {
      callType = 'Missed';
      callTypeColor = Colors.red;
      callTypeIcon = Icons.call_missed_outlined;
    } else {
      callType = 'Outgoing';
      callTypeIcon = Icons.call_made_outlined;
    }

    final formattedTimestamp = _formatTimestamp(callLog.timestamp);

    return ListTile(
      leading: const CircleAvatar(
        // You can display a photo here if available
        child: Icon(Icons.person),
      ),
      title: Text(
        callLog.name ?? callLog.number.toString(),
        style: const TextStyle(
          fontFamily: "Montserrat",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            callTypeIcon,
            color: const Color(0xffB2B8C2),
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            callType,
            style: TextStyle(
              color: callTypeColor,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formattedTimestamp,
            style: const TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                color: Color(0xffB2B8C2)),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xffECEEF2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.arrow_forward_ios,
                size: 18, color: Color(0xffB2B8C2)),
          ),
        ],
      ),
      onTap: () {
        // Define what happens when the tile is clicked
      },
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1B64FF),
        onPressed: () {
          //Contacts add function
        },
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsetsDirectional.only(top: 20),
          height: 44,
          decoration: BoxDecoration(
              color: const Color(0xffEFF1F8),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
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
      body: _callLogs.isNotEmpty
          ? ListView.separated(
              itemCount: _callLogs.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final callLog = _callLogs[index];
                return _buildCallLogTile(callLog);
              },
            )
          : const Center(
              child: Text('No call logs'),
            ),
    );
  }
}
