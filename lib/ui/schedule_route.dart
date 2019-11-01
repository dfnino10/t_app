import 'package:calendarro/date_utils.dart';
import 'package:calendarro/default_day_tile_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_app/ui/custemWeekdayLabelsView.dart';
import 'package:t_app/ui/customDayTileBuilder.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';

class ScheduleRoute extends StatefulWidget {
  @override
  _ScheduleRouteState createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute> {
  DateTime calendarStartDate = DateUtils.getFirstDayOfCurrentMonth();

  DateTime calendarEndDate = DateUtils.getLastDayOfCurrentMonth();

  List selectedDates = [];

  TimeOfDay selectedTime = TimeOfDay.now();

  int currentMonth = DateTime.now().month - 1;

  double originLat;

  double originLon;

  double destLat;

  double destLon;

  String originName;

  String destName;

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

  Future<void> _selectTime(BuildContext context) async {
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

  onPressNext(BuildContext context) {
    for (int i = 0; i < selectedDates.length; i++) {
      CollectionReference docRef = Firestore.instance.collection('trips');
      docRef.add(<String, dynamic>{
        'date': selectedDates[i],
        'arrival_time': selectedTime.format(context),
        'origin_lat': originLat,
        'origin_lon': originLon,
        'dest_lat': destLat,
        'dest_lon': destLon,
        'origin_name': originName,
        'dest_name': destName,
      });
    }

    print(Calendarro.of(context).selectedDates);
    hideModalBottomSheetCustom(
        context: context,
        builder: (BuildContext bc) {
          //emtpy on purpose
        });

//    }
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
        body: Column(
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
                          calendarEndDate =
                              DateUtils.getLastDayOfMonth(calendarStartDate);
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
                    if (date.isAfter(DateUtils.toMidnight(DateTime.now())) &&
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
                        _selectTime(context);
                      }))
            ]),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    onPressBack();
                  },
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Text("Aceptar"),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    onPressNext(context);
                  },
                )
              ],
            )
          ],
        ));
  }
}
