import 'package:flutter/material.dart';

import '../profile_fr_screen.dart';

class FollowersItem extends StatelessWidget {
  const FollowersItem({
    Key? key,
    required this.uid,
    required this.followrsList,
    required this.snap,
  }) : super(key: key);

  final String uid;
  final List followrsList;
  final Map<String, dynamic> snap;
  @override
  bool isCheckedInList() {
    for (var item in followrsList) {
      if (item == snap['uid']) return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: (isCheckedInList())
          ? Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    snap['photoUrl'],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileFrScreen(
                                  snap: snap,
                                  uid: uid,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            snap['username'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 3),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Follow',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(snap['bio']),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Text('Delete'),
                  ),
                )
              ],
            )
          : null,
    );
  }
}
