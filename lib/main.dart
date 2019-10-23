import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';
import 'package:t_app/ui/drawer_route.dart';
import 'package:t_app/ui/schedule_route.dart';
import 'package:connectivity/connectivity.dart';

void main() => {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then((_) {
        runApp(TApp());
      })
    };

class TApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Color(0xff3497fd), primaryColorDark: Color(0xff2a2e43)),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  GoogleMapController mapController;
  int markerId = 1;
  String placeToFind;
  static const LatLng _center = const LatLng(4.603112, -74.065193);
  String userName;
  int sadFaces;
  Image userPic;

  _MyHomeScreenState() {
    getUserInfo();
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (Connectivity().checkConnectivity() != ConnectivityResult.none) {
      Firestore.instance
          .collection('passengers')
          .document('6KAlH8I2hdWGKIVcSS1s')
          .get()
          .then((DocumentSnapshot ds) {
        setState(() {
          List data = ds.data.values.toList();
          this.userName = data[0];
          this.sadFaces = data[5];
        });
        prefs.setString('user_name', this.userName);
        prefs.setInt('sad_faces', this.sadFaces);
      });
    }
    else {
      this.userName = prefs.getString('user_name');
      this.sadFaces = prefs.getInt('sad_faces');
    }
  }

  findPlace() {
    Geolocator().placemarkFromAddress(placeToFind).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
      Marker newMarker = Marker(
        markerId: MarkerId(markerId.toString()),
        infoWindow: InfoWindow(title: "${result[0].name}", snippet: "*"),
        position:
            LatLng(result[0].position.latitude, result[0].position.longitude),
      );
      setState(() {
        markers[newMarker.markerId] = newMarker;
      });
      markerId++;
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerRoute(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: Set.from(markers.values),
          ),
          Positioned(
            top: 30,
            right: 15,
            left: 15,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: findPlace,
                      iconSize: 30.0,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      placeToFind = val;
                    });
                  }),
            ),
          ),
          Positioned(
              bottom: 20,
              right: 50,
              left: 50,
              child: FloatingActionButton.extended(
                label: Text("Programar viajes"),
                onPressed: () {
                  showModalBottomSheetCustom(
                      context: context,
                      builder: (BuildContext bc) {
                        return ScheduleRoute();
                      });
                },
              ))
        ],
      ),
    );
  }
}
