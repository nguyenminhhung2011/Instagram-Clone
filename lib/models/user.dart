import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String email;
  final String password;
  final String photoUrl;
  final String username;
  final String bio;
  final List followeres;
  final List following;
  final String uid;

  User({
    required this.email,
    required this.password,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followeres,
    required this.following,
    required this.uid,
  });
  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'bio': bio,
        'followers': followeres,
        'following': following,
        'photoUrl': photoUrl,
        'uid': uid,
      };
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      password: snapshot['password'],
      followeres: snapshot['followers'],
      following: snapshot['following'],
      username: snapshot['username'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      uid: snapshot['uid'],
    );
  }
}
