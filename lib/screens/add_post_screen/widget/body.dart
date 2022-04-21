import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/utils.dart';

class BodyAddPost extends StatefulWidget {
  const BodyAddPost({Key? key}) : super(key: key);

  @override
  State<BodyAddPost> createState() => _BodyAddPostState();
}

class _BodyAddPostState extends State<BodyAddPost> {
  Uint8List? _image;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  void selectedImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);

    setState(() {
      _image = image;
      //convertoBytes();
    });
  }

  void postImage(
    String username,
    String uid,
    String profImage,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      String res = await FireStoreMethods().upLoadPost(
          _image!, _descriptionController.text, uid, username, profImage);
      if (res == "success") {
        showSnackBar('Post Image success', context);
        _isLoading = false;
        clearImage();
      } else {
        showSnackBar(res, context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  @override
  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  Widget build(BuildContext context) {
    // lay user name da dang nhap
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _image == null
        ? Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      selectedImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Choose image from Computer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: (_image != null)
                          ? DecorationImage(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1649837662871-ea9d153c9765?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(userProvider.getUser.photoUrl),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1649837662871-ea9d153c9765?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80'),
                              ),
                        SizedBox(width: 20),
                        Text(
                          userProvider.getUser.username,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write  caption....',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(Icons.favorite),
                        Spacer(),
                        Text('0/2.000'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('Choose Address'),
                        Spacer(),
                        Icon(Icons.where_to_vote)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      postImage(
                        userProvider.getUser.username,
                        userProvider.getUser.uid,
                        userProvider.getUser.photoUrl,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent,
                        ),
                        child: (_isLoading)
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                children: [
                                  Text('Post this post'),
                                  Icon(Icons.add),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
