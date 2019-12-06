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
        user = email;
        return email;
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
      String passwordDigest = sha256.convert(utf8.encode(password)).toString();
  }

  Future<String> getCurrentUser() async {
    return await user;
  }
}
