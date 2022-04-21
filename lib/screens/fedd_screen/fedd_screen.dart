// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagran_tute/screens/fedd_screen/widgets/post_card.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../message_screen/message_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 40,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //make show dialog is full screerm
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext buildContext) {
                      return Dialog(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: MediaQuery.of(context).size.height - 80,
                          padding: EdgeInsets.all(20),
                          color: mobileBackgroundColor,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      10,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      80,
                                                ),
                                              );
                                            });
                                      },
                                      child: Text('Back'),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Messenger',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                          decoration: InputDecoration(
                                            hintText: 'Search here',
                                            border: InputBorder.none,
                                          ),
                                          onFieldSubmitted: (String _) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.send)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        children: snapshot.data!.docs
                            .map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(e.data()['photoUrl']),
                                  radius: 30,
                                ),
                              ),
                            )
                            .toList()),
                  );
                },
              ),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return Column(
                  children: snapshot.data!.docs
                      .map(
                        (e) => PostCard(
                          snap: e.data(),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 40,
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.send)),
        ],
      ),
    );
  }
}
