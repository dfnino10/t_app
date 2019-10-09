import 'package:flutter/material.dart';
import 'package:t_app/home_screen.dart';

void main() => runApp(TApp());

class TApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.blueAccent),
      home: MyHomeScreen(),
    );
  }
}

