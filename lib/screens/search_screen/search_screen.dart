import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagran_tute/screens/profile_user_screen/profile_fr_screen.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShower = false;
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: mobileBackgroundColor,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: mobileSearchColor,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(Icons.search),
              const SizedBox(width: 10),
              Container(
                width: 350,
                height: 50,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (String _) {
                    setState(() {
                      if (_searchController.text.isNotEmpty) {
                        isShower = true;
                      } else {
                        isShower = false;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: (isShower)
          ? FutureBuilder(
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return Column(
                  children: snapshot.data!.docs.map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    NetworkImage(e.data()['photoUrl']),
                                radius: 30),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        .getUser.uid)));
                                  },
                                  child: Text(
                                    e.data()['username'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  e.data()['bio'],
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            Spacer(),
                            (!e
                                    .data()['followers']
                                    .contains(userProvider.getUser.uid))
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueAccent,
                                    ),
                                    child: Text('Following'),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Text('Unfollow'),
                                  ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                );
              },
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: _searchController.text,
                  )
                  .get(),
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('Posts').get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return StaggeredGrid.count(
                  crossAxisCount: 5,
                  children: snapshot.data!.docs.map(
                    (e) {
                      return Container(
                        margin: const EdgeInsets.all(2),
                        child: Image.network(
                          e.data()['postUrl'],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
    );
  }
}
