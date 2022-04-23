// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/providers/user_provider.dart';
import 'package:instagran_tute/screens/message_screen/widgets/mainMessage_screen.dart';
import 'package:instagran_tute/screens/message_screen/widgets/message_user_item.dart';
import 'package:instagran_tute/screens/message_screen/widgets/rec_item.dart';
import 'package:instagran_tute/screens/message_screen/widgets/send_item.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShower = false;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width - 4,
      height: MediaQuery.of(context).size.height - 80,
      padding: EdgeInsets.all(20),
      color: mobileBackgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 10),
                Text(
                  userProvider.getUser.username,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.post_add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 0.3,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: mobileSearchColor,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(Icons.search),
                  const SizedBox(width: 10),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        border: InputBorder.none,
                      ),
                      onFieldSubmitted: (String _) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                children: [
                  Text('Messages'),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '1 request',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text)
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return Column(
                    children: snapshots.data!.docs.map((e) {
                  return MessageUserItem(
                    snap: e.data(),
                    userProvider: userProvider,
                  );
                }).toList());
              },
            )
          ],
        ),
      ),
    );
  }
}
