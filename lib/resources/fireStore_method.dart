import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagran_tute/models/Notification.dart';
import 'package:instagran_tute/models/message.dart';
import 'package:instagran_tute/models/post.dart';
import 'package:instagran_tute/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> upLoadPost(
    Uint8List file,
    String description,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some Occured";
    String postId = const Uuid().v1();
    // chua co ham creat nhu sign up nen phai goi ham uuid de tao uuid
    try {
      String photoUrl =
          await StorageMethods().UploadImageStorage('posts', file, true);
      Post post = Post(
        description: description,
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
        uid: uid,
        username: username,
        datePublished: DateTime.now(),
        postId: postId,
      );
      _firestore.collection('Posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      print(err.toString());
      res = err.toString();
    }
    return res;
  }

  Future<void> sendMessage(
    String photoUrl,
    String tittle,
    String uid1,
    String uid2,
    int typeMessage,
  ) async {
    String messId = const Uuid().v1();
    try {
      Message mess = Message(
        tittle: tittle,
        uid1: uid1,
        uid2: uid2,
        photoUrl: photoUrl,
        typeMessage: typeMessage,
        uidMessage: messId,
        date: DateTime.now(),
      );
      _firestore.collection('messages').doc(messId).set(mess.toJson());
      print('success');
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> upLoadNotifi(
    String uidOp,
    String uidUser,
    String uidPost,
    int typeNotifi,
  ) async {
    String noId = const Uuid().v1();
    try {
      NotifiCation noti = NotifiCation(
        uid: noId,
        uidOp: uidOp,
        uidUser: uidUser,
        uidPost: uidPost,
        typeNotifi: typeNotifi,
      );
      _firestore.collection('notifications').doc(noId).set(noti.toJson());
      print('success');
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> ListPost(String postUid, String uid, List Likes) async {
    try {
      if (Likes.contains(uid)) {
        await _firestore.collection('Posts').doc(postUid).update({
          'likes': FieldValue.arrayRemove([uid]) //Update likes posts
        });
      } else {
        await _firestore.collection('Posts').doc(postUid).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> following(String userId, String uid, List follows) async {
    try {
      if (follows.contains(uid)) {
        await _firestore.collection('users').doc(userId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([userId]),
        });
      } else {
        await _firestore.collection('users').doc(userId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([userId]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> deletePost(String postUid) async {
    try {
      await _firestore.collection('Posts').doc(postUid).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> likesCmt(
      String cmtID, String uid, List fav, String postId) async {
    try {
      if (fav.contains(uid)) {
        await _firestore
            .collection('Posts')
            .doc(postId)
            .collection('comments')
            .doc(cmtID)
            .update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore
            .collection('Posts')
            .doc(postId)
            .collection('comments')
            .doc(cmtID)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> postComment(
      String text, String postId, String name, String avt, String uid) async {
    try {
      if (text.isNotEmpty) {
        String cmtUid = const Uuid().v1();
        await _firestore
            .collection('Posts')
            .doc(postId)
            .collection('comments')
            .doc(cmtUid)
            .set({
          'commentId': cmtUid,
          'datePublished': DateTime.now(),
          'name': name,
          'avtPic': avt,
          'text': text,
          'usercmtUID': uid,
          'likes': [],
        });
      } else {
        print('Text is Empty');
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<List> getAllPosts(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Posts')
        // .where('uid', isGreaterThanOrEqualTo: uid)
        .get();
    final listP = querySnapshot.docs.map((e) => e.data()).toList();
    return listP;
  }
}
