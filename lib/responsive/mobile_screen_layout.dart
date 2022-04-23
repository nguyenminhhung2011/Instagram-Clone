import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/providers/user_provider.dart';
import 'package:instagran_tute/screens/LogIn_screen/login_screen.dart';
import 'package:instagran_tute/screens/Notification/notification_screen.dart';
import 'package:instagran_tute/screens/SignUp_screen/signUp_screen.dart';
import 'package:instagran_tute/screens/fedd_screen/fedd_screen.dart';
import 'package:instagran_tute/screens/profile_user_screen/profile_user_screen.dart';
import 'package:instagran_tute/screens/search_screen/search_screen.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:provider/provider.dart';
import '../models/user.dart' as model;
import '../screens/add_post_screen/add_post_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void NavigatorTapped(int val) {
    pageController.jumpToPage(val);
    setState(() {
      _page = val;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavi(
              icon: Icon(Icons.home,
                  color: (_page == 0) ? primaryColor : secondaryColor)),
          BottomNavi(
              icon: Icon(Icons.search,
                  color: (_page == 1) ? primaryColor : secondaryColor)),
          BottomNavi(
              icon: Icon(Icons.add_circle,
                  color: (_page == 2) ? primaryColor : secondaryColor)),
          BottomNavi(
              icon: Icon(Icons.favorite,
                  color: (_page == 3) ? primaryColor : secondaryColor)),
          BottomNavi(
              icon: Icon(Icons.person,
                  color: (_page == 4) ? primaryColor : secondaryColor)),
        ],
        onTap: NavigatorTapped,
      ),
      body: PageView(
        controller: pageController,
        children: [
          FeedScreen(),
          SearchScreen(),
          AddPostScreen(),
          NotificationScreen(),
          ProfileSreenn(uid: ""),
        ],
        //child: Text('hala'),
      ),
    );
  }

  BottomNavigationBarItem BottomNavi({required Icon icon}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: '',
      backgroundColor: primaryColor,
    );
  }
}
