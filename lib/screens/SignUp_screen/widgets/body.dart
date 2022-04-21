import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagran_tute/resources/auth_methods.dart';
import 'package:instagran_tute/utils/utils.dart';
import 'package:instagran_tute/widgets/formErrors.dart';

import '../../../responsive/mobile_screen_layout.dart';
import '../../../responsive/responsive_layout_screen.dart';
import '../../../responsive/web_screen_layout.dart';
import '../../../utils/colors.dart';
import '../../../widgets/button.dart';
import '../../../widgets/textField.dart';
import '../../LogIn_screen/widgets/body.dart';

class Body_signUp extends StatefulWidget {
  const Body_signUp({Key? key}) : super(key: key);

  @override
  State<Body_signUp> createState() => _Body_signUpState();
}

class _Body_signUpState extends State<Body_signUp> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final List<String> list_errors = ['errors demo', 'fuck djtme m'];
  final String errors = "";
  Uint8List? _image;
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
    _userNameController.dispose();
    _bioController.dispose();
  }

  void selectedImage() async {
    Uint8List im =
        await pickImage(ImageSource.gallery); //  pick Image from file
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailControler.text,
      password: _passwordControler.text,
      username: _userNameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 1,
          ),
          //Flexible(child: Container(), flex: 1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Image.asset(
                  'instagram.png',
                  height: 40,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png'),
                    ),
              Positioned(
                top: 120,
                left: 120,
                child: IconButton(
                  onPressed: () {
                    selectedImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          TextField_desgin(
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            hintText: "Please enter your Username",
            textEdittingCotroller: _userNameController,
          ),

          const SizedBox(height: 24),
          TextField_desgin(
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            hintText: "Please enter your Phone Number or Email",
            textEdittingCotroller: _emailControler,
          ),
          const SizedBox(height: 20),
          TextField_desgin(
            isPassword: true,
            textInputType: TextInputType.text,
            hintText: "Please enter your password",
            textEdittingCotroller: _passwordControler,
          ),
          const SizedBox(height: 24),
          TextField_desgin(
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            hintText: "Please enter your Bio",
            textEdittingCotroller: _bioController,
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: InkWell(
              onTap: () {
                signUpUser();
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: blueColor,
                ),
                child: (isLoading)
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
              ),
            ),
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
