import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:instagran_tute/screens/fedd_screen/widgets/post_card.dart';
import 'package:instagran_tute/screens/profile_user_screen/profile_fr_screen.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/change_pass.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/edit_profile_screen.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/followes_item.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/following_item.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/view_all_screen.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class ProfileSreenn extends StatefulWidget {
  final String uid;
  const ProfileSreenn({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileSreenn> createState() => _ProfileSreennState();
}

class _ProfileSreennState extends State<ProfileSreenn> {
  bool check_click = true;
  int countPost = 0;
  Map<String, dynamic> s = {};
  late List allP = [];
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    allP = await FireStoreMethods().getAllPosts('');
    setState(() {
      countPost = allP.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final List followersList = userProvider.getUser.followeres;
    final List followingList = userProvider.getUser.following;
    int countFollowing = userProvider.getUser.following.length;
    int returnPostLength() {
      int count = 0;
      for (var item in allP) {
        count += (item['uid'] == userProvider.getUser.uid) ? 1 : 0;
      }
      return count;
    }

    void _onRefresh() async {
      userProvider.refreshUser();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: InkWell(
          onTap: () async {
            List allP =
                await FireStoreMethods().getAllPosts(userProvider.getUser.uid);
            setState(() {
              countPost = returnPostLength();
            });
            print(allP.length);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              children: [
                Icon(Icons.lock_outline),
                const SizedBox(height: 20),
                Text(userProvider.getUser.username),
                const SizedBox(height: 20),
                Icon(Icons.arrow_drop_down),
                Spacer(),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: mobileBackgroundColor,
                  child: ChangePassScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.lock_outline,
            ),
          ),
          IconButton(
            onPressed: () {
              _settingBottomSheet(context);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 0.3,
              color: Colors.white.withOpacity(0.4),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          userProvider.getUser.photoUrl,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(userProvider.getUser.username),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        '${returnPostLength()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Post',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'Followers',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  height: 0.3,
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .get(),
                                  builder: (
                                    context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot,
                                  ) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      );
                                    }
                                    return Column(
                                      children: snapshot.data!.docs
                                          .map((e) => FollowersItem(
                                                uid: userProvider.getUser.uid,
                                                followrsList: followersList,
                                                snap: e.data(),
                                              ))
                                          .toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          '${userProvider.getUser.followeres.length}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Followes',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'Following',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  height: 0.3,
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .get(),
                                  builder: (
                                    context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot,
                                  ) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      );
                                    }
                                    return Column(
                                      children: snapshot.data!.docs
                                          .map(
                                            (e) => FollowingItem(
                                              snap: e.data(),
                                              followingList: followingList,
                                              uid: userProvider.getUser.uid,
                                            ),
                                          )
                                          .toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          '${countFollowing}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Following',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              userProvider: userProvider,
                            ),
                          ),
                        );
                        setState(() {
                          _onRefresh();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'Edit your Profile',
                          textAlign: TextAlign.center,
                        ),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    flex: 6,
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        check_click = !check_click;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: !(check_click)
                            ? Colors.black
                            : Color.fromARGB(218, 155, 144, 144),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child:
                          Icon(Icons.person_add, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Text(
                    'Discover People',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAllScreen(
                            userName: userProvider.getUser.username,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            //get all user from firebase
            (check_click)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot.data!.docs.map(
                              (e) {
                                return ProfileCard1(
                                  snap: e.data(),
                                  uid: userProvider.getUser.uid,
                                  press: () async {
                                    await FireStoreMethods().following(
                                        e.data()['uid'],
                                        userProvider.getUser.uid,
                                        e.data()['followers']);
                                    setState(() {
                                      _onRefresh();
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                Text(
                  'Your Post',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                // Ham FutureBuilder tra ve builder dang tuong lai
                future: FirebaseFirestore.instance
                    .collection('Posts')
                    .where('uid', isEqualTo: userProvider.getUser.uid)
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return YourPost(
                          snap: snap,
                          user: userProvider,
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class YourPost extends StatelessWidget {
  const YourPost({
    Key? key,
    required this.snap,
    required this.user,
  }) : super(key: key);

  final DocumentSnapshot<Object?> snap;
  final UserProvider user;
  @override
  Widget build(BuildContext context) {
    return (snap['uid'] == user.getUser.uid)
        ? InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: PostCard(
                    snap: snap,
                  ),
                ),
              );
            },
            child: Container(
              child: Image(
                image: NetworkImage(
                  snap['postUrl'],
                ),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container();
  }
}

void _settingBottomSheet(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 2 - 30,
              ),
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            OptionWidget(
              icon: Icon(Icons.settings),
              tittle: 'Settings',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.history),
              tittle: 'Storage',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.alarm),
              tittle: 'Your Activity',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.qr_code_scanner_sharp),
              tittle: 'QR - Code',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.bookmark_outline),
              tittle: 'Saved',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.reorder),
              tittle: 'Best Friend',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.star_outline),
              tittle: 'Favorite',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.coronavirus_rounded),
              tittle: '(Covid - 19) Information centre',
              press: () {},
            ),
            OptionWidget(
              icon: Icon(Icons.messenger_outline_outlined),
              tittle: 'Update messaging feature',
              press: () {},
            ),
          ],
        ),
      );
    },
  );
}

class OptionWidget extends StatelessWidget {
  final String tittle;
  final Widget icon;
  final Function() press;
  const OptionWidget({
    Key? key,
    required this.tittle,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: press,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                icon,
                const SizedBox(width: 10),
                Text(
                  tittle,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ProfileCard1 extends StatelessWidget {
  final Map<String, dynamic> snap;
  final String uid;
  final Function() press;
  const ProfileCard1({
    Key? key,
    required this.snap,
    required this.uid,
    required this.press,
  }) : super(key: key);
  bool isChecked() {
    for (var item in snap['followers']) {
      if (item == uid) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return (snap['uid'] != uid && isChecked())
        ? InkWell(
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
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              width: MediaQuery.of(context).size.width * 0.35,
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
                  Positioned(
                    left: 130,
                    top: 3,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.close),
                    ),
                  ),
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
                          onTap: press,
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
            ),
          )
        : Container();
  }
}
