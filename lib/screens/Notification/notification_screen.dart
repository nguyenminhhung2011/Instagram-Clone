import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/providers/user_provider.dart';
import 'package:instagran_tute/screens/Notification/widgets/notiFollow.dart';
import 'package:instagran_tute/screens/Notification/widgets/notifiPost.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
          StreamBuilder(
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: snapshots.data!.docs
                      .map(
                        (e) => chooseTypeNoti(
                          e: e.data(),
                        ),
                      )
                      .toList(),
                ),
              );
            },
            stream: FirebaseFirestore.instance
                .collection('notifications')
                .where('uidUser', isEqualTo: userProvider.getUser.uid)
                .snapshots(),
          ),
        ],
      ),
    );
  }
}

class chooseTypeNoti extends StatelessWidget {
  final Map<String, dynamic> e;
  const chooseTypeNoti({
    Key? key,
    required this.e,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (e['typeNotifi'] == 0)
        ? notiFollow(
            uidOp: e['uidOp'],
          )
        : NotifiPost(snap: e);
  }
}
