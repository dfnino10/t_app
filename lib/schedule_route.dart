import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';

class ScheduleRoute extends StatefulWidget {
  @override
  _ScheduleRouteState createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute> {
  List dates = List();

  month() {
    var monthNumber = DateTime.now().month;
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
      if (i == (monthNumber - 1)) {
        return months[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Container(
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 5,
                ),
                child: Text(
                  "Elije las fechas en las que quieres viajar:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 16),
                )),
            Row(children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back), iconSize: 12, autofocus: false),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(month())),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: 12,
                autofocus: false,
                // onPressed: () {Calendarro.of(context)},
              )
            ]),
            Calendarro(
              displayMode: DisplayMode.MONTHS,
              selectionMode: SelectionMode.MULTI,
              onTap: (date) {
                dates.add(date);
              },
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    print("lsaksadf");
                  },
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Text("Aceptar"),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    print("adf");
                  },
                )
              ],
            )
          ],
        ));
  }
}
