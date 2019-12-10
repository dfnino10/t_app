import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String phoneNumber, String password, String username,
      DateTime birthDate, String gender);

  Future<String> getCurrentUser();
}

class Auth implements BaseAuth {

  String user;

  final Firestore _firebaseAuth = Firestore.instance;

  Future<String> signIn(String email, String password) async {
    String emailDigest = sha256.convert(utf8.encode(email)).toString();
    var collection = await _firebaseAuth
        .collection('authentication')
        .document(emailDigest)
        .get();
    Map data = collection.data;
    if (data != null) {
      String pwDigest = sha256.convert(utf8.encode(password)).toString();
      if (pwDigest == data['password']) {
        String emailDigest2 = sha256.convert(utf8.encode(emailDigest)).toString();
        user = emailDigest2;
        return emailDigest2;
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  Future<String> signUp(String email, String phoneNumber, String password, String username,
      DateTime birthDate, String gender) async {
      String emailDigest = sha256.convert(utf8.encode(email)).toString();
      DocumentSnapshot doc = await _firebaseAuth.collection('authentication').document(emailDigest).get();
      if(!doc.exists) {
        String passwordDigest = sha256.convert(utf8.encode(password))
            .toString();
        await _firebaseAuth.collection('authentication')
            .document(emailDigest)
            .setData({'password': passwordDigest});
        String emailDigest2 = sha256.convert(utf8.encode(emailDigest))
            .toString();
        await _firebaseAuth.collection('passengers')
            .document(emailDigest2)
            .setData({
          'phone_number': phoneNumber,
          'name': username,
          'birthdate': birthDate,
          'gender': gender,
          'future_trips': [],
          'past_trips': [],
          'sad_faces': 0
        });
        user = emailDigest2;
        return emailDigest2;
      }
      else {
        return "";
      }
  }

  Future<String> getCurrentUser() async {
    return await user;
  }
}
