import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagran_tute/providers/user_provider.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:instagran_tute/resources/storage_methods.dart';
import 'package:instagran_tute/screens/message_screen/widgets/rec_item.dart';
import 'package:instagran_tute/screens/message_screen/widgets/send_item.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:instagran_tute/utils/utils.dart';

class MainMessage extends StatefulWidget {
  const MainMessage({
    Key? key,
    required this.snap,
    required this.userProvider,
  }) : super(key: key);

  final Map<String, dynamic> snap;
  final UserProvider userProvider;

  @override
  State<MainMessage> createState() => _MainMessageState();
}

class _MainMessageState extends State<MainMessage> {
  final TextEditingController _messController = TextEditingController();
  Uint8List? _image = null;
  bool isSendFile = false;
  bool isLoadingImageUpload = false;
  @override
  void dispose() {
    super.dispose();
    _messController.dispose();
  }

  void selectedImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
      isSendFile = true;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 4,
      height: MediaQuery.of(context).size.height - 80,
      padding: EdgeInsets.all(20),
      color: mobileBackgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.snap['photoUrl'],
                      ),
                      radius: 25,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.snap['username'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.call_outlined),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 0.3,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 7 * 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.snap['photoUrl']),
                          radius: 60,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.snap['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text('Instagram'),
                        const SizedBox(height: 5),
                        Text(
                          '${widget.snap['followers'].length} Followers . ${widget.snap['following'].length} Following',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'You guys are following each other on Instagram',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Follow ${widget.snap['username']} and 33 others',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SendItem(
                          tittle: "This is Messages",
                          linkImage: "",
                          typeMessage: 0,
                        ),
                        SendItem(
                          tittle: "This is Messages OK luon Ok Luon",
                          linkImage: "",
                          typeMessage: 0,
                        ),
                        SendItem(
                          tittle: "This is ",
                          linkImage: "",
                          typeMessage: 0,
                        ),
                        RecItem(
                          tittle: 'Oke Oke luon',
                          photoUrl: widget.snap['photoUrl'],
                          typeMessage: 0,
                          linkImage: "",
                        ),
                        RecItem(
                          tittle: 'Oke Oke luon',
                          photoUrl: widget.snap['photoUrl'],
                          typeMessage: 1,
                          linkImage:
                              "https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.6435-9/183151093_307118977572945_212309247841771097_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=e3f864&_nc_ohc=922MD3yWiRcAX8P7K4Q&_nc_ht=scontent.fsgn2-1.fna&oh=00_AT98nLDcJvlXQCk52T9PuxO_BDg1uZR4_2X0wunZOc9HOA&oe=6288F499",
                        ),
                        SendItem(
                          tittle: "De tao gui cho m cai hinh",
                          linkImage: "",
                          typeMessage: 0,
                        ),
                        SendItem(
                          tittle: "",
                          linkImage:
                              "https://scontent.fsgn2-1.fna.fbcdn.net/v/t39.30808-6/278953818_4902082829912141_754730703564157389_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=730e14&_nc_ohc=VSp8aySJnQ0AX_LIInF&_nc_ht=scontent.fsgn2-1.fna&oh=00_AT-nQnBis0mPPbF23ngIdtDT48yaWg06vyzuK-XKLKbIrA&oe=626797E4",
                          typeMessage: 1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            (!isSendFile)
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.9,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 230,
                          child: TextFormField(
                            controller: _messController,
                            decoration: InputDecoration(
                              hintText: 'Send Message',
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (String _) async {
                              await FireStoreMethods().sendMessage(
                                "",
                                _,
                                widget.userProvider.getUser.uid,
                                widget.snap['uid'],
                                0,
                              );
                              setState(() {
                                _messController.clear();
                              });
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.mic_outlined),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            selectedImage();
                          },
                          child: Icon(Icons.photo),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.gif_box_rounded),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: (!isLoadingImageUpload)
                        ? Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSendFile = false;
                                  });
                                },
                                icon: Icon(Icons.close),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(_image!),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoadingImageUpload = true;
                                  });
                                  String photoUrl = await StorageMethods()
                                      .UploadImageStorage(
                                          'messages', _image!, true);
                                  await FireStoreMethods().sendMessage(
                                    photoUrl,
                                    "",
                                    widget.userProvider.getUser.uid,
                                    widget.snap['uid'],
                                    1,
                                  );
                                  setState(() {
                                    isLoadingImageUpload = false;
                                    isSendFile = false;
                                  });
                                },
                                icon: Icon(Icons.send),
                              ),
                            ],
                          )
                        : Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
