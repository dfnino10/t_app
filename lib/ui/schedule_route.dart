import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';
import 'package:t_app/ui/custemWeekdayLabelsView.dart';
import 'package:t_app/ui/custom_bottom_sheet.dart';

enum WidgetMarker { dateTimeSelector, confirmTrip }

class ScheduleRoute extends StatefulWidget {
  @override
  _ScheduleRouteState createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute> {
  DateTime calendarStartDate = DateUtils.getFirstDayOfCurrentMonth();

  DateTime calendarEndDate = DateUtils.getLastDayOfCurrentMonth();

  WidgetMarker displayedWidget = WidgetMarker.dateTimeSelector;

  List dates = List();

  var selectedTime;

  int currentMonth = DateTime.now().month - 1;

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
          DateUtils.getFirstDayOfMonth(firstDayOfCurrentMonth).subtract(Duration(days: 1));
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

  Widget getWidgetToDisplay() {
    switch (displayedWidget) {
      case WidgetMarker.dateTimeSelector:
        return getDateTimeSelectorWidget();
      case WidgetMarker.confirmTrip:
        return getConfirmTripWidget();
    }
  }

  Widget getDateTimeSelectorWidget() {
    return Column(children: <Widget>[
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
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
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
                    calendarEndDate = removeMonths(calendarEndDate, 1);
                    calendarStartDate = DateUtils.getFirstDayOfMonth(calendarEndDate);
                    print(calendarStartDate.toString() +
                        calendarEndDate.toString());
                  });
                })),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(getCurrentMonthName(currentMonth) + " " + calendarStartDate.year.toString())),
        Container(
            child: IconButton(
          icon: Icon(Icons.arrow_forward),
          iconSize: 12,
          autofocus: false,
          onPressed: () {
            setState(() {
              print(currentMonth);
              currentMonth = (currentMonth + 1) % 12;
              calendarStartDate = DateUtils.addMonths(calendarStartDate, 1);
              calendarEndDate = DateUtils.addMonths(calendarEndDate, 2);
              print(calendarStartDate.toString() + calendarEndDate.toString());
            });
          },
        ))
      ]),
      Calendarro(
        weekdayLabelsRow: CustomWeekdayLabelsView(),
        startDate: calendarStartDate,
        endDate: calendarEndDate,
        displayMode: DisplayMode.MONTHS,
        selectionMode: SelectionMode.MULTI,
        onTap: (date) {
          if (!dates.contains(date)) {
            dates.add(date);
          } else {
            dates.remove(date);
          }
          print(dates);
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
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
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
    ]);
  }

  Widget getConfirmTripWidget() {
    return Text("confirm trip");
  }

  onPressNext() {
    if (displayedWidget == WidgetMarker.dateTimeSelector) {
      // showTimePicker(context: context, initialTime: TimeOfDay.now());
      setState(() {
        displayedWidget = WidgetMarker.confirmTrip;
      });
    } else if (displayedWidget == WidgetMarker.confirmTrip) {
      //save trip here
    }
  }

  onPressBack() {
    if (displayedWidget == WidgetMarker.dateTimeSelector) {
      hideModalBottomSheetCustom(
          context: context,
          builder: (BuildContext bc) {
            //emtpy on purpose
          });
    } else if (displayedWidget == WidgetMarker.confirmTrip) {
      setState(() {
        displayedWidget = WidgetMarker.dateTimeSelector;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            getWidgetToDisplay(),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: displayedWidget == WidgetMarker.dateTimeSelector
                      ? Text("Cancelar")
                      : Text("Atrás"),
                  onPressed: () {
                    onPressBack();
                  },
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Text("Aceptar"),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    onPressNext();
                  },
                )
              ],
            )
          ],
        ));
  }
}
