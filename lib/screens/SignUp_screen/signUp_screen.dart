import 'package:flutter/material.dart';
import 'package:instagran_tute/screens/SignUp_screen/widgets/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Body_signUp(),
    );
  }
}
