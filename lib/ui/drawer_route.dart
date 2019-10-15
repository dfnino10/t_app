import 'package:flutter/material.dart';
import 'package:t_app/ui/user_profile_route.dart';

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
        Container(
          color: Theme.of(context).primaryColorDark,
          child: Container(
            height: 220,
            child: DrawerHeader(
              child: Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    onDetailsPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileRoute()));
                    },
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark),
                    accountName: Text(
                      "Juan Gómez",
                      style: TextStyle(color: Colors.white),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: Text("JG"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.face,
                          color: Colors.white,
                        ),
                        Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        ListTile(
          title: Text("Viajes futuros"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Historial de viajes"),
          onTap: () {},
        )
      ],
    ));
  }
}
