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
          backgroundColor: Theme.of(context).primaryColorDark,
        ),
        body: Column(
          children: <Widget>[
            Text("Historial de viajes", style: TextStyle(fontSize: 20)),
//            ListView(
//      children: <Widget>[
//            Card(
//              child: Column(
//                children: <Widget>[Text("asdf"), Text("jkñl")],
//              ),
//            )
//      ],
//    ),
          ],
        ));
  }
}
