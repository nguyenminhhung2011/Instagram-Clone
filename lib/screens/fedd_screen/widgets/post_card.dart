import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagran_tute/providers/user_provider.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:instagran_tute/screens/comment_screen/commnet_screen.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.snap['profImage']),
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
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                    onTap: () async {
                                      await FireStoreMethods()
                                          .deletePost(widget.snap['postId']);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.snap['postUrl']),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await FireStoreMethods().ListPost(widget.snap['postId'],
                          userProvider.getUser.uid, widget.snap['likes']);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: (widget.snap['likes']
                              .contains(userProvider.getUser.uid))
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: mobileBackgroundColor,
                          child: CommentScreen(
                            snap: widget.snap,
                            userProvider: userProvider,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.comment_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.bookmark_border)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.w800),
                          child: Text(
                            '${widget.snap['likes'].length} likes',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: TextStyle(color: primaryColor),
                          children: [
                            TextSpan(
                              text: widget.snap['username'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              text: widget.snap['description'],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'view all 200 commnets',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      //['Date'].toString(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
