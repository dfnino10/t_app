import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';

class ScheduleRoute extends StatefulWidget {
  @override
  _ScheduleRouteState createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute> {
  var dates = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Elige las fechas en las que quieres viajar:",
              textAlign: TextAlign.left,
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
            )),
        Calendarro(
          displayMode: DisplayMode.MONTHS,
          selectionMode: SelectionMode.MULTI,
          onTap: (date) {
            dates.add(date);
          },
        ),
        // ButtonBar(
        //   alignment: MainAxisAlignment.end,
        //   children: <Widget>[
        //     FlatButton(
        //       child: Text("asdf"),
        //     )
        //   ],
        // )
      ],
    ));
  }
}
