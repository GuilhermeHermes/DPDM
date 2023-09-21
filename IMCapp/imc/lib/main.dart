import 'dart:math';

import 'package:flutter/material.dart';
import 'home/home.dart';

void main() {
  runApp(MaterialApp(
    title: "BFCalc",
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: Home(),
  ));
}
