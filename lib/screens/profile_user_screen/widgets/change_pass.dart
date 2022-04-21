import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagran_tute/resources/auth_methods.dart';
import 'package:instagran_tute/resources/fireStore_method.dart';
import 'package:instagran_tute/utils/colors.dart';
import 'package:instagran_tute/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _passController.dispose();
    _repassController.dispose();
    _newPassController.dispose();
  }

  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance.collection('users');
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline),
                const SizedBox(width: 10),
                Text(
                  'Change Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: 1000,
              height: 0.3,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            TextFieldPass(
              hintText: 'Enter your password',
              textCotroller: _passController,
              icon: Icon(Icons.lock),
            ),
            const SizedBox(height: 20),
            TextFieldPass(
              hintText: 'Enter re-password',
              textCotroller: _repassController,
              icon: Icon(
                Icons.lock_outline,
              ),
            ),
            const SizedBox(height: 20),
            TextFieldPass(
              hintText: 'Enter new password',
              textCotroller: _newPassController,
              icon: Icon(Icons.key),
            ),
            const SizedBox(height: 12),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                if (_passController.text.isEmpty ||
                    _repassController.text.isEmpty ||
                    _newPassController.text.isEmpty) {
                  showSnackBar('Input is null', context);
                } else {
                  if (_passController.text == _repassController.text) {
                    if (_passController.text == userProvider.getUser.password) {
                      await snapshots.doc(userProvider.getUser.uid).update({
                        'password': _newPassController.text,
                      }).then((value) {
                        showSnackBar('Change pass success', context);
                      }).catchError((err) {
                        showSnackBar(err.toString(), context);
                      });
                      await AuthMethods()
                          .changePasswrod(_newPassController.text);
                      setState(() {
                        userProvider.refreshUser();
                        _passController.clear();
                        _repassController.clear();
                        _newPassController.clear();
                      });
                    } else {
                      showSnackBar('Pass is not true', context);
                    }
                  } else {
                    showSnackBar('Re pass not true', context);
                  }
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Change Pass'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldPass extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final TextEditingController textCotroller;
  const TextFieldPass({
    Key? key,
    required this.hintText,
    required this.textCotroller,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: mobileSearchColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Container(
            width: 310,
            height: 50,
            child: TextFormField(
              controller: textCotroller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
