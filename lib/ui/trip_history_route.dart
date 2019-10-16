import 'dart:io';

import 'package:flutter/material.dart';

class TripHistoryRoute extends StatefulWidget {
  @override
  _TripHistoryRouteState createState() => _TripHistoryRouteState();
}

class _TripHistoryRouteState extends State<TripHistoryRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de viajes"),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "10/10/19 - 20:15",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: Row(
                    children: <Widget>[
                      Container(height: 50, padding: EdgeInsets.only(right: 10),child: Image.asset("lib/assets/trip_icon.png")),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Origen", style: TextStyle(fontSize: 10)),
                                  Text("asdfadsfkadsfsadfh", style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Destino", style: TextStyle(fontSize: 10)),
                                Text("asdlkfksdjah", style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ]),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
