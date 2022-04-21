import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:instagran_tute/screens/profile_user_screen/profile_user_screen.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/followes_item.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/following_item.dart';
import 'package:instagran_tute/screens/profile_user_screen/widgets/view_all_screen.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../fedd_screen/widgets/post_card.dart';

class ProfileFrScreen extends StatefulWidget {
  final Map<String, dynamic> snap;
  final String uid;
  const ProfileFrScreen({
    Key? key,
    required this.snap,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileFrScreen> createState() => _ProfileFrScreenState();
}

class _ProfileFrScreenState extends State<ProfileFrScreen> {
  bool isChecked = false;
  bool isCheckedClieck = true;
  int countPost = 0;
  late List allP = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      for (var item in widget.snap['followers']) {
        isChecked = (item == widget.uid) ? true : isChecked;
      }
    });
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
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final List followersList = widget.snap['followers'];
    final List followingList = widget.snap['following'];
    int returnPostLength() {
      int count = 0;
      for (var item in allP) {
        count += (item['uid'] == widget.snap['uid']) ? 1 : 0;
      }
      return count;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(widget.snap['username']),
        backgroundColor: mobileBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
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
                            widget.snap['photoUrl'],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(widget.snap['username']),
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
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .snapshots(),
                                    builder: (
                                      context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
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
                            '${widget.snap['followers'].length}',
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
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .snapshots(),
                                    builder: (
                                      context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
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
                            '${widget.snap['following'].length}',
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
                          await FireStoreMethods().following(
                            widget.snap['uid'],
                            widget.uid,
                            widget.snap['followers'],
                          );
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: (isChecked)
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  'You are following',
                                  textAlign: TextAlign.center,
                                ),
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  'Following',
                                  textAlign: TextAlign.center,
                                ),
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.blueAccent,
                                ),
                              ),
                      ),
                      flex: 8,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
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
                      flex: 8,
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCheckedClieck = !isCheckedClieck;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: !(isCheckedClieck)
                              ? Colors.black
                              : Color.fromARGB(218, 155, 144, 144),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Icon(Icons.person_add,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Suggestions for you',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAllScreen(
                              userName: widget.uid,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'View all',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              (isCheckedClieck)
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
                                    uid: widget.uid,
                                    press: () async {
                                      await FireStoreMethods().following(
                                          e.data()['uid'],
                                          userProvider.getUser.uid,
                                          e.data()['followers']);
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
                      .where('uid', isEqualTo: widget.snap['uid'])
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
                            userName: snap['username'],
                            user: userProvider,
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class YourPost extends StatelessWidget {
  const YourPost({
    Key? key,
    required this.snap,
    required this.userName,
    required this.user,
  }) : super(key: key);

  final DocumentSnapshot<Object?> snap;
  final String userName;
  final UserProvider user;
  @override
  Widget build(BuildContext context) {
    return (snap['username'] == userName)
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
