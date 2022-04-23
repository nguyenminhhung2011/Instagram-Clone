// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:instagran_tute/screens/message_screen/widgets/mainMessage_screen.dart';

import '../../../providers/user_provider.dart';

class MessageUserItem extends StatelessWidget {
  final Map<String, dynamic> snap;
  final UserProvider userProvider;
  const MessageUserItem({
    Key? key,
    required this.snap,
    required this.userProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (userProvider.getUser.uid == snap['uid'])
        ? Container()
        : InkWell(
            onTap: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => Dialog(
                  child: MainMessage(
                    snap: snap,
                    userProvider: userProvider,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          snap['photoUrl'],
                        ),
                        radius: 25,
                      ),
                      Positioned(
                        top: 40,
                        left: 40,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 77, 174, 80),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snap['username'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Message nearest'),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
