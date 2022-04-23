import 'package:cloud_firestore/cloud_firestore.dart';

class NotifiCation {
  final String uid;
  final int typeNotifi;
  final String uidOp;
  final String uidUser;
  final String uidPost;
  const NotifiCation({
    required this.uid,
    required this.typeNotifi,
    required this.uidOp,
    required this.uidUser,
    required this.uidPost,
  });

  static NotifiCation fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return NotifiCation(
      uid: snapshot['uid'],
      typeNotifi: snapshot['typeNotifi'],
      uidOp: snapshot['uidOp'],
      uidUser: snapshot['uidUser'],
      uidPost: snapshot['uidPost'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "typeNotifi": typeNotifi,
        "uidOp": uidOp,
        "uidUser": uidUser,
        "uidPost": uidPost,
      };
}
