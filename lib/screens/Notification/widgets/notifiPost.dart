import 'package:flutter/material.dart';
import 'package:instagran_tute/screens/fedd_screen/widgets/post_card.dart';
import 'package:instagran_tute/utils/colors.dart';

import '../../../resources/fireStore_method.dart';

class NotifiPost extends StatefulWidget {
  final Map<String, dynamic> snap;
  const NotifiPost({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<NotifiPost> createState() => _NotifiPostState();
}

class _NotifiPostState extends State<NotifiPost> {
  Map<String, dynamic> p = {};
  Map<String, dynamic> usOp = {};
  List pSnap = [];
  List userOpSnap = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    pSnap = await FireStoreMethods().getAllPosts("");
    userOpSnap = await FireStoreMethods().getUser(widget.snap['uidOp']);
    setState(() {
      for (var item in pSnap) {
        if (item['postId'] == widget.snap['uidPost']) {
          p = item;
          break;
        }
      }
      for (var item in userOpSnap) {
        usOp = item;
      }
      isLoading = true;
    });
  }

  Widget build(BuildContext context) {
    return (isLoading)
        ? InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: mobileBackgroundColor,
                  child: PostCard(snap: p),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      usOp['photoUrl'],
                    ),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: usOp['username'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: " "),
                            (widget.snap['typeNotifi'] == 1)
                                ? TextSpan(text: "is like your post")
                                : TextSpan(text: "comments on your Post"),
                          ],
                        ),
                      ),
                      Text(usOp['bio']),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 50,
                    height: 50,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        p['postUrl'],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
