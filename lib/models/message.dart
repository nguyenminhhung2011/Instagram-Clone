import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String tittle;
  final String uid1;
  final String uid2;
  final String photoUrl;
  final int typeMessage;
  final String uidMessage;
  final DateTime date;
  Message({
    required this.tittle,
    required this.uid1,
    required this.uid2,
    required this.photoUrl,
    required this.typeMessage,
    required this.uidMessage,
    required this.date,
  });
  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Message(
      tittle: snapshot['tittle'],
      uid1: snapshot['uid1'],
      uid2: snapshot['uid2'],
      photoUrl: snapshot['photoUrl'],
      typeMessage: snapshot['typeMessage'],
      uidMessage: snapshot['uidMessage'],
      date: snapshot['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tittle': tittle,
        'uid1': uid1,
        'uid2': uid2,
        'photoUrl': photoUrl,
        'typeMessage': typeMessage,
        'uidMessage': uidMessage,
        'date': date,
      };
}
