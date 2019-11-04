import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_app/service/authentication.dart';


//code based on https://medium.com/flutterpub/flutter-how-to-do-user-login-with-firebase-a6af760b14d5

class LoginRoute extends StatefulWidget {

  LoginRoute({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  String email;
  String password;
  bool isLoginForm = true;
  final formKey = new GlobalKey<_LoginRouteState>();

  _LoginRouteState() {}

//  void toggleFormMode() {
//    resetForm();
//    setState(() {
//      isLoginForm = !isLoginForm;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        key: formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: new InputDecoration(
                  hintText: 'Correo electrónico',
                  icon: new Icon(
                    Icons.mail,
                    color: Colors.grey,
                  )),
              validator: (value) =>
                  value.isEmpty ? 'Email can\'t be empty' : null,
              onSaved: (value) => email = value.trim(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              obscureText: true,
              autofocus: false,
              decoration: new InputDecoration(
                  hintText: 'Contraseña',
                  icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  )),
              validator: (value) =>
                  value.isEmpty ? 'Password can\'t be empty' : null,
              onSaved: (value) => password = value.trim(),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
              child: SizedBox(
                height: 40.0,
                child: new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.blue,
                  child: new Text(
                      /*isLoginForm ?*/ 'Login' /*: 'Create account'*/,
                      style:
                          new TextStyle(fontSize: 20.0, color: Colors.white)),
//                    onPressed: validateAndSubmit,
                ),
              )),
          FlatButton(
            child: new Text(
//                  isLoginForm
//                      ? 'Create an account':
                'Have an account? Sign in',
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
//              onPressed: toggleFormMode
          )
        ]),
      ),
    );
  }
}
