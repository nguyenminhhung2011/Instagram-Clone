import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagran_tute/models/user.dart' as model;
import 'package:instagran_tute/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _fireStore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // Sign Up method
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    if (file == null) {
      res = "File Not Null";
      return res;
    } else {
      try {
        if (email.isNotEmpty &&
            password.isNotEmpty &&
            username.isNotEmpty &&
            bio.isNotEmpty &&
            // ignore: unnecessary_null_comparison
            file != null) {
          // register user
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
            // cai nay do co ham nen no tu tao uuid
            email: email, password: password,
          );
          // add user to database
          print(cred.user!.uid);
          //upload file
          String photoUrl = await StorageMethods()
              .UploadImageStorage('ProfilePic', file, false);
          model.User user = model.User(
            username: username,
            password: password,
            email: email,
            photoUrl: photoUrl,
            bio: bio,
            followeres: [],
            following: [],
            uid: cred.user!.uid,
          );
          await _fireStore.collection('users').doc(cred.user!.uid).set(
                // this function to create data to firebase database
                user.toJson(),
              );

          res = "success";
        } else {
          res = "Input is null";
          return res;
        }
      } on FirebaseAuthException catch (err) {
        print(err.code);
        if (err.code == 'weak-password') {
          res = 'Password should be at least 6 characters';
        } else if (err.code == 'invalid-email') {
          res = 'The Email address is badly formatted';
        } else if (err.code == 'email-already-in-use') {
          res = 'The Email address is already in use by another account';
        }
      }
    }
    return res;
  }

  // Log in method
  Future<String> LoginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter or fields';
        return res;
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email address is badly formatted';
      } else if (err.code == 'user-not-found') {
        res = 'the user is not found';
      } else if (err.code == 'wrong-password') {
        res = 'The password is invalid';
      }
    }
    return res;
  }

  Future<void> changePasswrod(String newPass) async {
    User user = _auth.currentUser!;
    user.updatePassword(newPass).then((value) {
      print('Success');
    }).catchError((err) {
      print(err.toString());
    });
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }
}
