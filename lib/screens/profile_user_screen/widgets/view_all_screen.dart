import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/screens/fedd_screen/widgets/post_card.dart';
import 'package:instagran_tute/screens/profile_user_screen/profile_fr_screen.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/profile_card.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class ViewAllScreen extends StatefulWidget {
  final String userName;
  const ViewAllScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isChecked(String uid) {
      for (var item in userProvider.getUser.following) {
        if (item == uid) return true;
        print(item + " " + uid);
      }
      print("");
      return false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text('Discover People'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where(
              'uid',
              isNotEqualTo: userProvider.getUser.uid,
            )
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 0.3,
                  color: Colors.white.withOpacity(0.4),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.blue),
                        ),
                        child: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 34,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find Facebook Friends',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          Text('Add yout account'),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: Text('Find'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 0.3,
                  color: Colors.white.withOpacity(0.4),
                ),
                Column(
                    children: snapshot.data!.docs.map((e) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: (userProvider.getUser.uid == e.data()['uid'])
                        ? Container(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(e.data()['photoUrl']),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileFrScreen(
                                                      snap: e.data(),
                                                      uid: userProvider
                                                          .getUser.uid),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          e.data()['username'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.check_circle_sharp,
                                        color: Colors.blue,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  Text(
                                      'Having ${e.data()['followers'].length} followers')
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue,
                                  ),
                                  child: Text('Following'),
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.close)),
                            ],
                          ),
                  );
                }).toList()),
              ],
            ),
          );
        },
      ),
    );
  }
}
