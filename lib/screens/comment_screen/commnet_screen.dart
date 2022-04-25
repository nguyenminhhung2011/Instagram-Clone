import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/providers/user_provider.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatefulWidget {
  final UserProvider userProvider;
  final Map<String, dynamic> snap;
  const CommentScreen({
    Key? key,
    required this.userProvider,
    required this.snap,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _cmtController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _cmtController.dispose();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'],
                  ),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.snap['username'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
                const SizedBox(width: 5),
                Text(widget.snap['description']),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 1000,
            height: 0.3,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 10),
          StreamBuilder(
            builder: (
              context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: snapshot.data!.docs.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(e.data()['avtPic']),
                            radius: 20,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  children: [
                                    TextSpan(
                                      text: e.data()['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        height: 1.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(text: ' '),
                                    TextSpan(
                                      text: e.data()['text'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(e['datePublished'].toDate()),
                                    //['Date'].toString(),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      await FireStoreMethods().likesCmt(
                                        e.data()['commentId'],
                                        widget.userProvider.getUser.uid,
                                        e.data()['likes'],
                                        widget.snap['postId'],
                                      );
                                    },
                                    child: Text(
                                      'Like',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: (e.data()['likes'].contains(
                                          widget.userProvider.getUser.uid,
                                        ))
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              Text(
                                '${e.data()['likes'].length}',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            stream: FirebaseFirestore.instance
                .collection('Posts')
                .doc(widget.snap['postId'])
                .collection('comments')
                .snapshots(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: mobileSearchColor,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 500,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.userProvider.getUser.photoUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 250,
                    height: 50,
                    child: TextFormField(
                      controller: _cmtController,
                      decoration: InputDecoration(
                        hintText: 'Comment as username',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () async {
                      await FireStoreMethods().postComment(
                        _cmtController.text,
                        widget.snap['postId'],
                        widget.userProvider.getUser.username,
                        widget.userProvider.getUser.photoUrl,
                        widget.userProvider.getUser.uid,
                      );
                      await FireStoreMethods().upLoadNotifi(
                        widget.userProvider.getUser.uid,
                        widget.snap['uid'],
                        widget.snap['postId'],
                        2,
                      );
                      _cmtController.clear();
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
