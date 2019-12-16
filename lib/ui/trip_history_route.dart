import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:t_app/service/ConnectionStatusSingleton.dart';
import 'package:t_app/service/firebase_service.dart';

class TripHistoryRoute extends StatefulWidget {
  String userId;

  TripHistoryRoute(this.userId);

  @override
  _TripHistoryRouteState createState() => _TripHistoryRouteState();
}

class _TripHistoryRouteState extends State<TripHistoryRoute> {
  List trips = [];

  ConnectionStatusSingleton conn;

  StreamSubscription _streamSubscription;

  bool _flushBarOn;

  bool _connected;

  Flushbar flushbar;

  @override
  void initState() {
    super.initState();
    flushbar = Flushbar(message: "Sin conexión");
    conn = ConnectionStatusSingleton.getInstance();
    _connected = conn.hasConnection;
    if(_connected) {
      getHistory();
      _flushBarOn = false;
    }
    else{
      WidgetsBinding.instance
          .addPostFrameCallback((_) => flushbar.show(context));

      _flushBarOn = true;
    }
    _streamSubscription = conn.connectionChange.listen(_validateConnection);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void _validateConnection(dynamic hasConnection) {
    if (hasConnection == false) {
      if (_flushBarOn == false) {
        setState(() {
          _connected = hasConnection;
          _flushBarOn = true;
          flushbar.show(context);
        });
      }
    } else {
      if (_flushBarOn == true) {
        setState(() {
          _connected = hasConnection;
          _flushBarOn = false;
          flushbar.dismiss(true);
          getHistory();
        });
      }
    }
  }

  getHistory() async {
    if (await conn.checkConnection()) {
      List trips = await FirebaseService.getPastTrips(widget.userId);
      setState(() {
        this.trips = trips;
      });
    }
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
        title: Text("Historial de viajes"),
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
