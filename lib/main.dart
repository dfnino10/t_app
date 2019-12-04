import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_app/service/authentication.dart';
import 'package:t_app/ui/root_page.dart';

//code based on https://github.com/tattwei46/flutter_login_demo/blob/master/lib/pages/root_page.dart

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
      home: new RootPage(auth: new Auth()),
    );
  }
}