import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';
import 'package:calendarro/default_day_tile.dart';
import 'package:flutter/material.dart';

class CustomDayTileBuilder extends DayTileBuilder {
  CustomDayTileBuilder();

  @override
  Widget build(BuildContext context, DateTime date, DateTimeCallback onTap) {
    return CustomCalendarroDayItem(
        date: date, calendarroState: Calendarro.of(context), onTap: onTap);
  }
}

class CustomCalendarroDayItem extends StatelessWidget {
  CustomCalendarroDayItem({this.date, this.calendarroState, this.onTap});

  DateTime date;
  CalendarroState calendarroState;
  DateTimeCallback onTap;

  @override
  Widget build(BuildContext context) {
    var textColor = Colors.black;
    var a = date.isBefore(DateUtils.toMidnight(DateTime.now()).add(Duration(days: 1)));
    if (a) {
      textColor = Colors.grey;
    }
    bool isToday = DateUtils.isToday(date);
    calendarroState = Calendarro.of(context);

    bool daySelected = calendarroState.isDateSelected(date);

    BoxDecoration boxDecoration;
    if (daySelected) {
      boxDecoration = BoxDecoration(color: Colors.blue, shape: BoxShape.circle);
    } else if (isToday) {
      boxDecoration = BoxDecoration(
          border: Border.all(
            color: Theme.of(context).accentColor,
            width: 1.0,
          ),
          shape: BoxShape.circle);
    }

    return Expanded(
        child: GestureDetector(
      child: Container(
          height: 40.0,
          decoration: boxDecoration,
          child: Center(
              child: Text(
            "${date.day}",
            textAlign: TextAlign.center,
            style: DateUtils.isWeekend(date) ? TextStyle(color: textColor, fontWeight: FontWeight.bold) : TextStyle(color: textColor) ,
          ))),
      onTap: handleTap,
      behavior: HitTestBehavior.translucent,
    ));
  }

  void handleTap() {
    if(date.isAfter(DateUtils.toMidnight(DateTime.now()))) {
      if(calendarroState.selectedDates.length < 5) {
        calendarroState.toggleDateSelection(date);
      }
      else {
        calendarroState.selectedDates.remove(date);
      }
    }
    if (onTap != null) {
      onTap(date);
    }
  }
}
