import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagran_tute/screens/add_post_screen/widget/body.dart';
import 'package:instagran_tute/utils/colors.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     padding: const EdgeInsets.all(10),
        //     onPressed: () {
        //       if (Navigator.canPop(context)) {
        //         Navigator.pop(context);
        //       }
        //     },
        //     icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: mobileBackgroundColor,
        title: Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: BodyAddPost(),
    );
  }
}
