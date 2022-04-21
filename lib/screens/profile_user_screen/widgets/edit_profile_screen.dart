import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagran_tute/providers/user_provider.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:instagran_tute/utils/utils.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProvider userProvider;
  const EditProfileScreen({Key? key, required this.userProvider})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameControler = TextEditingController();
  late TextEditingController _bioControler = TextEditingController();
  late TextEditingController _linkWebControler = TextEditingController();
  late TextEditingController _storyController = TextEditingController();
  Uint8List? _img;
  @override
  void selectedImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _img = im;
    });
  }

  void initState() {
    super.initState();
    _nameControler =
        new TextEditingController(text: widget.userProvider.getUser.username);
    _bioControler =
        new TextEditingController(text: widget.userProvider.getUser.bio);
    _storyController =
        new TextEditingController(text: widget.userProvider.getUser.password);
  }

  @override
  void dispose() {
    super.dispose();
    _nameControler.dispose();
    _bioControler.dispose();
    _linkWebControler.dispose();
    _storyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance.collection('users');
    var snapshotsPosts = FirebaseFirestore.instance.collection('Posts');
    var snapshotsCmts = FirebaseFirestore.instance
        .collection('Posts')
        .doc()
        .collection('comments');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Edit Your Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              if (_nameControler.text.isEmpty || _bioControler.text.isEmpty) {
                showSnackBar('username, bio, Story is not null', context);
              } else {
                //update user
                await snapshots.doc(widget.userProvider.getUser.uid).update({
                  'username': _nameControler.text,
                  'bio': _bioControler.text,
                }).then((value) {
                  showSnackBar('Update success', context);
                }).catchError((err) {
                  showSnackBar(err.toString(), context);
                });
              }
            },
            icon: Icon(
              Icons.check_outlined,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (_img == null)
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        widget.userProvider.getUser.photoUrl,
                      ),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundImage: MemoryImage(
                        _img!,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              selectedImage();
            },
            child: Text(
              'Change Your Avatar',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                TextField_Design(
                  nameControler: _nameControler,
                  labelText: 'Username',
                  hintText: 'Input new username',
                  checkPass: false,
                ),
                const SizedBox(height: 10),
                TextField_Design(
                  nameControler: _bioControler,
                  labelText: 'Bio',
                  hintText: 'Input new Bio',
                  checkPass: false,
                ),
                const SizedBox(height: 10),
                TextField_Design(
                  nameControler: _linkWebControler,
                  labelText: 'Link Web',
                  hintText: 'Your Web',
                  checkPass: false,
                ),
                const SizedBox(height: 10),
                TextField_Design(
                  nameControler: _storyController,
                  labelText: 'Story',
                  hintText: 'Input new Story',
                  checkPass: false,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Line(),
              Button_container(
                press: () {},
                tittle: 'switch to work account',
              ),
              Line(),
              Button_container(
                press: () {},
                tittle: 'Create Avatar',
              ),
              Line(),
              Button_container(
                press: () {},
                tittle: 'Setting inforamtion',
              ),
              Line(),
            ],
          ),
        ],
      ),
    );
  }
}

class Button_container extends StatelessWidget {
  final Function() press;
  final String tittle;
  const Button_container({
    Key? key,
    required this.press,
    required this.tittle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Text(
          tittle,
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.3,
      color: Colors.white.withOpacity(0.4),
    );
  }
}

class TextField_Design extends StatelessWidget {
  final TextEditingController nameControler;
  final String hintText;
  final String labelText;
  final bool checkPass;
  const TextField_Design({
    Key? key,
    required this.nameControler,
    required this.hintText,
    required this.labelText,
    required this.checkPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 17),
      controller: nameControler,
      obscureText: checkPass,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }
}
