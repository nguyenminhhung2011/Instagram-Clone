import 'package:flutter/material.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:instagran_tute/screens/profile_user_screen/profile_fr_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class notiFollow extends StatefulWidget {
  final String uidOp;
  const notiFollow({
    required this.uidOp,
    Key? key,
  }) : super(key: key);

  @override
  State<notiFollow> createState() => _notiFollowState();
}

class _notiFollowState extends State<notiFollow> {
  List userSnap = [];
  Map<String, dynamic> us = {};
  bool isLoading = false;
  bool isFollow = false;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    userSnap = await FireStoreMethods().getUser(widget.uidOp);
    setState(() {
      for (var item in userSnap) {
        us = item;
      }
      isLoading = true;
    });
  }

  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isCheckFollow() {
      for (var item in userProvider.getUser.following) {
        if (item == us['uid']) return true;
      }
      return false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: (isLoading)
          ? Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    us['photoUrl'],
                  ),
                  radius: 25,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileFrScreen(
                                snap: us, uid: userProvider.getUser.uid),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: us['username'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: " "),
                            TextSpan(text: "started following you"),
                          ],
                        ),
                      ),
                    ),
                    Text(us['bio']),
                  ],
                ),
                Spacer(),
                (!isCheckFollow())
                    ? InkWell(
                        onTap: () async {
                          await FireStoreMethods().following(us['uid'],
                              userProvider.getUser.uid, us['followers']);
                          setState(() {
                            userProvider.refreshUser();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('Follow'),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          await FireStoreMethods().following(us['uid'],
                              userProvider.getUser.uid, us['followers']);
                          setState(() {
                            userProvider.refreshUser();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                          child: Text('Unfollow'),
                        ),
                      )
              ],
            )
          : null,
    );
  }
}
