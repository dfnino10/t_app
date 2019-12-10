import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t_app/service/firebase_service.dart';

class FutureTripsRoute extends StatefulWidget {
  String userId;

  FutureTripsRoute(this.userId);

  @override
  _FutureTripsRouteState createState() => _FutureTripsRouteState();
}

class _FutureTripsRouteState extends State<FutureTripsRoute> {
  List trips = [];

  @override
  void initState() {
    super.initState();
    getTrips();
  }

  getTrips() async {
    List trips = await FirebaseService.getFutureTrips(widget.userId);
    setState(() {
      this.trips = trips;
    });
  }

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString() +
        " " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Viajes futuros"),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) =>
            buildList(context, index),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return (Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              formatDate(trips[index]['arrival_datetime']),
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Row(
              children: <Widget>[
                Container(
                    height: 50,
                    padding: EdgeInsets.only(right: 10),
                    child: Image.asset("lib/assets/trip_icon.png")),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Origen", style: TextStyle(fontSize: 10)),
                            Text(
                                (trips[index]['origin_name']).toString() == null
                                    ? 'Algo'
                                    : (trips[index]['origin_name']).toString(),
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Destino", style: TextStyle(fontSize: 10)),
                          Text(
                              (trips[index]['dest_name']).toString() == null
                                  ? 'Algo'
                                  : (trips[index]['dest_name']).toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ]),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
