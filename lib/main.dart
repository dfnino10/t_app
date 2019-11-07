import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_app/service/authentication.dart';
import 'package:t_app/ui/login_route.dart';
import 'package:t_app/ui/main_route.dart';


//codigo basado en https://github.com/tattwei46/flutter_login_demo/blob/master/lib/pages/root_page.dart

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

  Auth auth = new Auth();

  String userId = "";

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;

  @override
  void initState() {
    super.initState();
    auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
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

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      userId = "";
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
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          );
        break;
      case AuthStatus.LOGGED_IN:
        if (userId.length > 0 && userId != null) {
          return new MainRoute(
            userId: this.userId,
            auth: auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
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
