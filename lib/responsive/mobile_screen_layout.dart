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

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

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

  List<Widget> pages = const [
    Text('Home', style: _textStyle),
    Text('Search', style: _textStyle),
    Text('Post', style: _textStyle),
    Text('Notification', style: _textStyle),
    Text('Profile', style: _textStyle),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blueAccent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        child: NavigationBar(
          backgroundColor: mobileBackgroundColor,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 60,
          selectedIndex: _page,
          onDestinationSelected: (int newIndex) {
            pageController.jumpToPage(newIndex);
            setState(
              () {
                _page = newIndex;
              },
            );
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              selectedIcon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle),
              selectedIcon: Icon(Icons.add_circle),
              label: 'Post',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              selectedIcon: Icon(Icons.favorite),
              label: 'Notification',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),
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
