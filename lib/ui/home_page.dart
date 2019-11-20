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
import 'package:t_app/service/authentication.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';
import 'package:t_app/ui/drawer_route.dart';
import 'package:t_app/ui/login_route.dart';
import 'package:t_app/ui/home_page.dart';
import 'package:t_app/ui/schedule_route.dart';
import 'package:connectivity/connectivity.dart';
import 'package:t_app/ui/connectivity_check.dart';

class HomePage extends StatefulWidget {

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  const HomePage({Key key, this.auth, this.logoutCallback, this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

const apiK = 'AIzaSyDdDcFKetlYs88Ij8hlGIwNsuUDVvs1fsw';


class _HomePageState extends State<HomePage> {

  GoogleMapController mapController;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiK);
  String placeToFind1;
  String placeToFind2;
  static const LatLng _center = const LatLng(4.603112, -74.065193);
  final _myController1 = TextEditingController();
  final _myController2 = TextEditingController();

  String userName;
  int sadFaces;
  Image userPic;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  _HomePageState() {
    getUserInfo();
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  findPlace() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: apiK,
        mode: Mode.overlay,
      );
      displayPrediction(p);
    } else {}
  }

  findPlace2() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: apiK,
        mode: Mode.overlay,
      );
      displayPrediction2(p);
    } else {}
  }

  Future<Null> displayPrediction(Prediction p) async {
    int markerId1 = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15.0)));
      Marker newMarker = Marker(
        markerId: MarkerId(markerId1.toString()),
        infoWindow: InfoWindow(
            title: "${detail.result.name}",
            snippet: "${detail.result.formattedAddress}"),
        position: LatLng(lat, lng),
      );
      setState(() {
        markers[newMarker.markerId] = newMarker;
        placeToFind1 = detail.result.name;
      });
      prefs.setDouble('origin_lat', lat);
      prefs.setDouble('origin_lon', lng);
      prefs.setString('origin_name', detail.result.name);
      _myController1.text = placeToFind1;
    }
  }

  Future<Null> displayPrediction2(Prediction p) async {
    int markerId2 = 2;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15.0)));
      Marker newMarker = Marker(
        markerId: MarkerId(markerId2.toString()),
        infoWindow: InfoWindow(
            title: "${detail.result.name}",
            snippet: "${detail.result.formattedAddress}"),
        position: LatLng(lat, lng),
      );
      setState(() {
        markers[newMarker.markerId] = newMarker;
        placeToFind2 = detail.result.name;
      });
      prefs.setDouble('dest_lat', lat);
      prefs.setDouble('dest_lon', lng);
      prefs.setString('dest_name', detail.result.name);
      _myController2.text = placeToFind2;
    }
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
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
    } else {
      this.userName = prefs.getString('user_name');
      this.sadFaces = prefs.getInt('sad_faces');
    }
  }

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
                    controller: _myController1,
                    decoration: InputDecoration(
                      hintText: '¿A dónde quieres ir?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        iconSize: 30.0,
                      ),
                    ),
                    onTap: findPlace,
                    onChanged: (val) {
                      setState(() {
                        placeToFind1 = val;
                      });
                    })),
          ),
          Positioned(
            top: 80,
            right: 15,
            left: 15,
            child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: TextField(
                    controller: _myController2,
                    decoration: InputDecoration(
                      hintText: '¿Punto de partida?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        iconSize: 30.0,
                      ),
                    ),
                    onTap: findPlace2,
                    onChanged: (val) {
                      setState(() {
                        placeToFind2 = val;
                      });
                    })),
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
              )),
          ConnectivityCheck()
        ],
      ),
    );
  }
}
