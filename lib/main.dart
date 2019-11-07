import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_app/service/authentication.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';
import 'package:t_app/ui/drawer_route.dart';
import 'package:t_app/ui/login_route.dart';
import 'package:t_app/ui/main_route.dart';
import 'package:t_app/ui/schedule_route.dart';
import 'package:connectivity/connectivity.dart';
import 'package:t_app/ui/connectivity_check.dart';

void main() => {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then((_) {
        runApp(TApp());
      })
    };

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class TApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Color(0xff3497fd), primaryColorDark: Color(0xff2a2e43)),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  BaseAuth auth;

  String userId = "";
  AuthStatus authStatus = AuthStatus.LOGGED_IN;

  _MyHomeScreenState() {
  }

  @override
  void initState() {
    super.initState();
//    auth.getCurrentUser().then((user) {
//      setState(() {
//        if (user != null) {
//          userId = user?.uid;
//        }
//        authStatus =
//        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
//      });
//    });
  }

  void loginCallback() {
    auth.getCurrentUser().then((user) {
      setState(() {
        userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.NOT_DETERMINED:
        buildWaitingScreen();
        break;
      case AuthStatus.LOGGED_IN:
        return MainRoute();
      break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: auth,
          loginCallback: loginCallback,
        );
        break;
    }
  }
}
