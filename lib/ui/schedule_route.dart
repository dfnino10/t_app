import 'package:calendarro/date_utils.dart';
import 'package:calendarro/default_day_tile_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_app/service/ConnectivityService.dart';
import 'package:t_app/ui/connectivity_check.dart';
import 'package:t_app/ui/customWeekdayLabelsView.dart';
import 'package:t_app/ui/customDayTileBuilder.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';

class ScheduleRoute extends StatefulWidget {
  String userId;

  ScheduleRoute(this.userId);

  @override
  _ScheduleRouteState createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute> {
  DateTime calendarStartDate = DateUtils.getFirstDayOfCurrentMonth();

  DateTime calendarEndDate = DateUtils.getLastDayOfCurrentMonth();

  List<DateTime> selectedDates = [];

  TimeOfDay selectedTime = TimeOfDay.now();

  int currentMonth = DateTime.now().month - 1;

  double originLat;

  double originLon;

  double destLat;

  double destLon;

  String originName;

  String destName;

  bool showButtons = true;

  ConnectivityService conn = ConnectivityService();

  _ScheduleRouteState() {
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      this.originLat = pref.getDouble('origin_lat');
      this.originLon = pref.getDouble('origin_lon');
      this.destLat = pref.getDouble('dest_lat');
      this.destLon = pref.getDouble('dest_lon');
      this.originName = pref.getString('origin_name');
      this.destName = pref.getString('dest_name');
    });
  }

  String getCurrentMonthName(int month) {
    var months = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];
    for (var i = 0; i < months.length; i++) {
      if (i == month) {
        return months[i];
      }
    }
  }

  DateTime removeMonths(DateTime fromMonth, int months) {
    DateTime firstDayOfCurrentMonth = fromMonth;
    for (int i = 0; i < months; i++) {
      firstDayOfCurrentMonth =
          DateUtils.getFirstDayOfMonth(firstDayOfCurrentMonth)
              .subtract(Duration(days: 1));
    }

    return firstDayOfCurrentMonth;
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  onPressNext(BuildContext context) async {

    setState(() {
      showButtons = false;
    });

    String snackbarText = conn.getConnectivityStatus() != ConnectivityResult.none ? "Viajes programados" : "No tienes conexión, tus viajes se programarán automáticamente cuando la recuperes";

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(snackbarText),
      duration: Duration(seconds: 60),
      action: SnackBarAction(
        label: "Aceptar",
        onPressed: () {
          hideModalBottomSheetCustom(
              context: context,
              builder: (BuildContext bc) {
                //emtpy on purpose
              });
        },
      ),
    ));

    List<Map<String, dynamic>> newTrips = new List();

    for (int i = 0; i < selectedDates.length; i++) {
      newTrips.add(<String, dynamic>{
        'arrival_datetime': selectedDates[i].add(new Duration(hours: selectedTime.hour, minutes: selectedTime.minute)),
        'origin_lat': originLat,
        'origin_lon': originLon,
        'dest_lat': destLat,
        'dest_lon': destLon,
        'origin_name': originName,
        'dest_name': destName,
        'cancelled': false
      });
    }

    CollectionReference collection = await Firestore.instance.collection('future_trips');
    List<DocumentReference> trips = [];
    for(int i = 0; i < newTrips.length; i ++) {
      DocumentReference docRef = await collection.add(newTrips[i]);
      trips.add(docRef);
    }

    DocumentSnapshot doc = await Firestore.instance.collection('passengers').document(widget.userId).get();
    if(doc != null) {
      List future_trips = doc['future_trips'];
      for(int i = 0; i < future_trips.length; i++) {
        trips.add(future_trips[i]);
      }
      await Firestore.instance.collection('passengers').document(widget.userId).updateData({'future_trips': trips});
    }
  }

  onPressBack() {
    hideModalBottomSheetCustom(
        context: context,
        builder: (BuildContext bc) {
          //emtpy on purpose
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 5,
                      ),
                      child: Text(
                        "Fechas de viaje",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 16),
                      )),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                iconSize: 12,
                                autofocus: false,
                                onPressed: () {
                                  setState(() {
                                    currentMonth = (currentMonth - 1) % 12;
                                    calendarEndDate =
                                        removeMonths(calendarEndDate, 1);
                                    calendarStartDate =
                                        DateUtils.getFirstDayOfMonth(
                                            calendarEndDate);
                                  });
                                })),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(getCurrentMonthName(currentMonth) +
                                " " +
                                calendarStartDate.year.toString())),
                        Container(
                            child: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          iconSize: 12,
                          autofocus: false,
                          onPressed: () {
                            setState(() {
                              currentMonth = (currentMonth + 1) % 12;
                              calendarStartDate =
                                  DateUtils.addMonths(calendarStartDate, 1);
                              calendarEndDate = DateUtils.getLastDayOfMonth(
                                  calendarStartDate);
                            });
                          },
                        ))
                      ]),
                  Calendarro(
                    weekdayLabelsRow: CustomWeekdayLabelsView(),
                    dayTileBuilder: CustomDayTileBuilder(),
                    startDate: calendarStartDate,
                    endDate: calendarEndDate,
                    displayMode: DisplayMode.MONTHS,
                    selectionMode: SelectionMode.MULTI,
                    onTap: (date) {
                      setState(() {
                        if (date.isAfter(
                                DateUtils.toMidnight(DateTime.now())) &&
                            !selectedDates.contains(date)) {
                          selectedDates.add(date);
                        } else {
                          selectedDates.remove(date);
                        }
                      });
                    },
                  ),
                  Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsets.only(
                        bottom: 5,
                        left: 5,
                      ),
                      child: Text(
                        "Hora de llegada:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 16),
                      )),
                  Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: FlatButton(
                          child: Text(selectedTime != null
                              ? selectedTime.format(context)
                              : TimeOfDay.now().format(context)),
                          onPressed: () {
                            selectTime(context);
                          }))
                ]),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (showButtons)
                      RaisedButton(
                        child: Text("Cancelar"),
                        onPressed: () {
                          onPressBack();
                        },
                      ),
                    if (showButtons)
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text("Aceptar"),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (selectedTime == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Elige un tiempo de llegada")));
                          } else if (originLat == null || originLon == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Elige una ubicación de salida")));
                          } else if (destLat == null || destLon == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Elige una ubicación de destino")));
                          } else if (selectedDates.length == 0) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Elige por lo menos una fecha para los viajes")));
                          } else {
                            onPressNext(context);
                          }
                        },
                      )
                  ],
                )
              ],
            );
          },
        ));
  }
}
