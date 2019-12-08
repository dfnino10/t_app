import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// código basado en: https://github.com/flutter/flutter/issues/27821#issuecomment-462646527

class MyDropDown extends StatefulWidget {
  List<String> items;

  InputDecoration decoration;

  ValueChanged<String> onChanged;

  String value;

  MyDropDown({
    this.items,
    this.decoration,
    this.onChanged,
    this.value,
    Key key,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String selected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: (value) => value == null ? "Elige un género" : null,
      decoration: widget.decoration,
      value: selected,
      items: widget.items
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        setState(() => {
          selected = value
        });
        widget.onChanged(value);
      },
    );
  }
}
