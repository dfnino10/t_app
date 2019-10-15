import 'package:flutter/material.dart';

class DrawerRoute extends StatefulWidget {
  @override
  _DrawerRouteState createState() => _DrawerRouteState();
}

class _DrawerRouteState extends State<DrawerRoute> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
            child: Text(
              "Menú",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(color: Theme.of(context).accentColor)),
        ListTile(
          title: Text("Perfil de usuario"),
          onTap: () {},
        )
      ],
    ));
  }
}
