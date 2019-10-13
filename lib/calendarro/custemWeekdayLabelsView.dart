import 'package:flutter/widgets.dart';

class CustomWeekdayLabelsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("Lun", textAlign: TextAlign.center)),
        Expanded(child: Text("Mar", textAlign: TextAlign.center)),
        Expanded(child: Text("Wie", textAlign: TextAlign.center)),
        Expanded(child: Text("Jue", textAlign: TextAlign.center)),
        Expanded(child: Text("Vie", textAlign: TextAlign.center)),
        Expanded(child: Text("Sab", textAlign: TextAlign.center)),
        Expanded(child: Text("Dom", textAlign: TextAlign.center)),
      ],
    );
  }
}