import 'package:flutter/material.dart';
import 'package:instagran_tute/screens/Notification/widgets/notiFollow.dart';
import 'package:instagran_tute/screens/Notification/widgets/notifiPost.dart';
import 'package:instagran_tute/utils/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.notifications),
        backgroundColor: mobileBackgroundColor,
        title: Text('Activity', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('New', style: TextStyle(fontSize: 17)),
          ),
          const SizedBox(height: 20),
          notiFollow(),
          NotifiPost()
        ],
      ),
    );
  }
}
