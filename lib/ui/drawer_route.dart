import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_app/ui/trip_history_route.dart';
import 'package:t_app/ui/user_profile_route.dart';

class DrawerRoute extends StatefulWidget {
  DrawerRoute();

  @override
  _DrawerRouteState createState() => _DrawerRouteState();
}

class _DrawerRouteState extends State<DrawerRoute> {
  String userName;

  int sadFaces;

  @override
  void initState() {
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      setState(() {
        this.userName = pref.getString('user_name');
        this.sadFaces = pref.getInt('sad_faces');
      });
    });
    super.initState();
  }

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
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark),
                    accountName: Text(
                      this.userName != null ? this.userName : "",
                      style: TextStyle(color: Colors.white),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: Text(this.userName != null ? this.userName.split(" ")[0]: ""), backgroundColor: Theme.of(context).accentColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            this.sadFaces.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Image.asset('lib/assets/frown.png', color: Colors.white)
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
          onTap: () {
            //TODO open future trips route here
          },
        ),
        ListTile(
          title: Text("Historial de viajes"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TripHistoryRoute()));
          },
        )
      ],
    ));
  }
}
