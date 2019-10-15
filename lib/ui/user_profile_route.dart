import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileRoute extends StatefulWidget {
  @override
  _UserProfileRouteState createState() => _UserProfileRouteState();
}

class _UserProfileRouteState extends State<UserProfileRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 50, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 300,
                child: TextFormField(
                  initialValue: "Juan Gómez",
                ),
              ),
              Text("Nombre"),
              Container(
                width: 300,
                child: TextFormField(
                  initialValue: "jgomez@gmail.com",
                ),
              ),
              Text("Correo electrónico"),
              FlatButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  "Guardar cambios",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              )
            ],
          )),
    );
  }
}
