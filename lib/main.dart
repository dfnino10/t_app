import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';
import 'package:t_app/ui/drawer_route.dart';
import 'package:t_app/ui/schedule_route.dart';
import 'package:t_app/ui/connectivity_check.dart';

void main() => runApp(TApp());

const apiK = 'AIzaSyDdDcFKetlYs88Ij8hlGIwNsuUDVvs1fsw';

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
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiK);
  int markerId = 1;
  String placeToFind;
  static const LatLng _center = const LatLng(4.603112, -74.065193);
  final _myController1 = TextEditingController();

  void _onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  findPlace() async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiK,
      mode: Mode.overlay,
    );
    displayPrediction(p);
  }

  Future<Null> displayPrediction(Prediction p) async {
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
        markerId: MarkerId(markerId.toString()),
        infoWindow: InfoWindow(
            title: "${detail.result.name}",
            snippet: "${detail.result.formattedAddress}"),
        position: LatLng(lat, lng),
      );
      setState(() {
        markers[newMarker.markerId] = newMarker;
        placeToFind = detail.result.name;
      });
      _myController1.text = placeToFind;
      markerId++;
    }
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
                    controller: _myController1,
                    decoration: InputDecoration(
                      hintText: '¿A dónde quieres ir?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: findPlace,
                        iconSize: 30.0,
                      ),
                    ),
                    onTap: findPlace,
                    onChanged: (val) {
                      setState(() {
                        placeToFind = val;
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
