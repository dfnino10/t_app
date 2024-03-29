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
import 'package:t_app/service/google_maps_requests.dart' as prefix0;
import 'package:t_app/service/google_maps_requests.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';
import 'package:t_app/ui/drawer_route.dart';
import 'package:t_app/ui/login_route.dart';
import 'package:t_app/ui/home_page.dart';
import 'package:t_app/ui/schedule_route.dart';
import 'package:connectivity/connectivity.dart';
import 'package:t_app/ui/connectivity_check.dart';
import 'package:t_app/service/Bluetooth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  const HomePage({Key key, this.auth, this.logoutCallback, this.userId})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

const apiK = 'AIzaSyDdDcFKetlYs88Ij8hlGIwNsuUDVvs1fsw';

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;
  prefix0.GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiK);
  String placeToFind1;
  String placeToFind2;
  LatLng position1;
  LatLng position2;
  static const LatLng _center = const LatLng(4.603112, -74.065193);
  final _myController1 = TextEditingController();
  final _myController2 = TextEditingController();
  final Set<Polyline> _polyLines = {};

  String userName;
  int sadFaces;
  Image userPic;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: DrawerRoute(
          logoutCallback: widget.logoutCallback, userId: widget.userId),
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
            polylines: _polyLines,
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
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ]),
                child: TextField(
                    controller: _myController1,
                    decoration: InputDecoration(
                      hintText: '¿A dónde quieres ir?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.trip_origin),
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
            top: 140,
            right: 15,
            left: 15,
            child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ]),
                child: TextField(
                    controller: _myController2,
                    decoration: InputDecoration(
                      hintText: '¿Punto de partida?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.location_on),
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
              top: 200,
              right: 50,
              left: 50,
              child: FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: Text("Toca para comprobar tu identidad."),
                  heroTag: "hero",
                  onPressed: () {
                    showModalBottomSheetCustom(
                        context: context,
                        builder: (BuildContext context) {
                      return Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FlatButton(
                                  child: Text("Comprobar mediante Bluetooth"),
                                  onPressed: () {
                                    showModalBottomSheetCustom(
                                        context: context,
                                        builder: (BuildContext context){
                                          return BluetoothApp();
                                        }
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FlatButton(
                                  child: Text("Comprobar mediante QR"),
                                  onPressed: () {
                                    showModalBottomSheetCustom(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Center (
                                            widthFactor: 2,
                                            heightFactor: 2,
                                            child: QrImage(
                                              data: "1234567890",
                                              version: QrVersions.auto,
                                              size: 200.0,
                                            ),
                                          );
                                        }
                                    );
                                  },
                                ),
                              ),
                            ]),
                      );
                    });
                  })),
          Positioned(
              bottom: 20,
              right: 50,
              left: 50,
              child: FloatingActionButton.extended(
                label: Text("Programar viajes"),
                backgroundColor: (position1 != null && position2 != null) ? Theme.of(context).accentColor : Colors.grey,
                onPressed: () {
                  if(position1 != null && position2 != null) {
                  showModalBottomSheetCustom(
                      context: context,
                      builder: (BuildContext bc) {
                        return ScheduleRoute(userId: widget.userId, originLat: position2.latitude, originLon: position2.longitude, destLat: position1.latitude, destLon: position1.longitude, originName: placeToFind2, destName: placeToFind1);
                      });
                  }
                  else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                      return SimpleDialog(
                        title:
                        Text("Elige un origen y destino primero"),
                        children: <Widget>[
                          SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Aceptar"))
                        ],
                      );
                    });
                  }
                },
              )),
          ConnectivityCheck(),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  findPlace() async {
    bool connected = await isConnected();
    if (connected) {
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          apiKey: apiK,
          mode: Mode.fullscreen,
          language: "es",
          components: [Component(Component.country, "co")]);
      displayPrediction(p);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("No tienes conexión"),
            );
          });
    }
  }

  findPlace2() async {
    bool connected = await isConnected();
    if (connected) {
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          apiKey: apiK,
          mode: Mode.fullscreen,
          components: [Component(Component.country, "co")]);
      displayPrediction2(p);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("No tienes conexión"),
            );
          });
    }
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;
      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    return lList;
  }

  Future<Null> displayPrediction(Prediction p) async {
    int markerId1 = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool connected = await isConnected();
    if (p != null && connected) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

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
        position1 = newMarker.position;
      });
      _myController1.text = placeToFind1;
    } else if (!connected) {}
  }

  Future<Null> displayPrediction2(Prediction p) async {
    int markerId2 = 2;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

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
        position2 = newMarker.position;
      });

      _myController2.text = placeToFind2;

      String route = await _googleMapsServices.getRouteCoordinates(
          position1, LatLng(lat, lng));
      createRoute(route);
    }
  }

  void createRoute(String encodedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(position1.toString()),
          width: 10,
          points: _convertToLatLng(_decodePoly(encodedPoly)),
          color: Colors.black));
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      Firestore.instance
          .collection('passengers')
          .document(widget.userId)
          .get()
          .then((DocumentSnapshot ds) {
        setState(() {
          Map data = ds.data;
          this.userName = data['name'];
          this.sadFaces = data['sad_faces'];
        });
        prefs.setString('user_name', this.userName);
        prefs.setInt('sad_faces', this.sadFaces);
      });
    } else {
      this.userName = prefs.getString('user_name');
      this.sadFaces = prefs.getInt('sad_faces');
    }
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }
}
