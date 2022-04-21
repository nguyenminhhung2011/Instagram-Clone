import 'package:flutter/material.dart';

import '../profile_fr_screen.dart';

class FollowingItem extends StatelessWidget {
  final Map<String, dynamic> snap;
  final List followingList;
  final String uid;
  const FollowingItem({
    Key? key,
    required this.snap,
    required this.followingList,
    required this.uid,
  }) : super(key: key);

  @override
  bool isCheckedFollowing() {
    for (var item in followingList) {
      if (item == snap['uid']) return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    return (isCheckedFollowing())
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(snap['photoUrl']),
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
                    Text(snap['bio']),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.blueAccent,
                    ),
                    child: Text('Following'),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
