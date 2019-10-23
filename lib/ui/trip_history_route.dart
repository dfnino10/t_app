import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripHistoryRoute extends StatefulWidget {
  @override
  _TripHistoryRouteState createState() => _TripHistoryRouteState();
}

class _TripHistoryRouteState extends State<TripHistoryRoute> {
  List trips = [];
  /*{'origin': 'Casa', 'destination': 'Uniandes', 'date': '10/10/19 - 7:20'},
    {'origin': 'Uniandes', 'destination': 'Casa', 'date': '9/10/19 - 18:30'},
    {'origin': 'Uniandes', 'destination': 'Casa', 'date': '7/10/19 - 18:45'},
    {'origin': 'Uniandes', 'destination': 'Casa', 'date': '6/10/19 - 20:00'},
    {'origin': 'Casa', 'destination': 'Uniandes', 'date': '3/10/19 - 7:42'}*/

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  getHistory(){
    Firestore.instance.collection('trips').getDocuments().then((docs){
      if(docs.documents.isNotEmpty){
        setState(() {

        });
        for(int i = 0; i< docs.documents.length; ++i){
          if(docs.documents[i].data['origin_name'] != null){
            trips.add(docs.documents[i].data);
          }

        }
      }
    });
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
              (trips[index]['date']).toDate().toString(),
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
                            Text((trips[index]['origin_name']).toString() == null ? 'Algo':(trips[index]['origin_name']).toString(),
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Destino", style: TextStyle(fontSize: 10)),
                          Text((trips[index]['dest_name']).toString() == null ? 'Algo':(trips[index]['dest_name']).toString(),
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
