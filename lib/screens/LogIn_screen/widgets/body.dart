import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagran_tute/screens/home_screen/home_screen.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:instagran_tute/utils/utils.dart';
import 'package:instagran_tute/widgets/button.dart';
import 'package:instagran_tute/widgets/formErrors.dart';
import 'package:instagran_tute/widgets/textField.dart';

import '../../../resources/auth_methods.dart';
import '../../../responsive/mobile_screen_layout.dart';
import '../../../responsive/responsive_layout_screen.dart';
import '../../../responsive/web_screen_layout.dart';
import '../../SignUp_screen/signUp_screen.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  bool isLoading = false;
  bool isLoadingWithFacebook = false;
  String errors = "";
  //TextEditingController co nhieim vu la lay gia tri thay doi cua textField
  @override
  void dispose() {
    super.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
  }

  void LoginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().LoginUser(
      email: _emailControler.text,
      password: _passwordControler.text,
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
          const SizedBox(height: 30),
          Button_Design(
            content: "Log In",
            press: () {
              LoginUser();
            },
            isLoading: isLoading,
            ishaveIcon: false,
          ),
          const SizedBox(height: 20),
          Text_onTapText(
            content1: 'Forgot your login information!',
            content2: 'Get help to sign in now',
            press: () {},
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color:
                          Color.fromARGB(255, 243, 242, 242).withOpacity(0.3),
                    ),
                  ),
                  Text('Sign in another way'),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color:
                          Color.fromARGB(255, 243, 242, 242).withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Button_Design(
            content: 'Continue with Facebook',
            press: () {},
            ishaveIcon: true,
            isLoading: isLoadingWithFacebook,
          ),
          const SizedBox(height: 20),
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Color.fromARGB(255, 226, 221, 221).withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text_onTapText(
              content1: 'Don\'t have account?',
              content2: 'Sign Up',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Text_onTapText extends StatelessWidget {
  final String content1;
  final String content2;
  final Function() press;
  const Text_onTapText({
    Key? key,
    required this.content1,
    required this.content2,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(content1),
        ),
        InkWell(
          onTap: press,
          child: Container(
            child: Text(
              content2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
