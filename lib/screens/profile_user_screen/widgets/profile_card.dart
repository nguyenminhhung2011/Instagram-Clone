import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  final String userName;
  const ProfileCard({
    Key? key,
    required this.snap,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (snap['username'] != userName)
        ? Container(
            margin: const EdgeInsets.only(right: 5),
            width: 180,
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        backgroundImage: NetworkImage(snap['photoUrl']),
                        radius: 50,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        snap['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(top: 2),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          width: double.infinity,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Following',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
