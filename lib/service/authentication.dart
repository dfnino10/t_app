import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//code based on https://medium.com/flutterpub/flutter-how-to-do-user-login-with-firebase-a6af760b14d5

abstract class BaseAuth {
  Future<void> signIn(String email, String password);

  Future<String> signUp(String email, String password, String username, DateTime birthDate, String gender);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//  Future<String> signIn(String email, String password) async {
//    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
//        email: email, password: password);
//    FirebaseUser user = result.user;
//    return user.uid;
//  }

  Future<void> signIn(String email, String password) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


  Future<String> signUp(String email, String password, String username, DateTime birthDate, String gender) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}