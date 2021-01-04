import 'package:flutter/material.dart';
import 'package:school_wall_app/app.dart';
import 'package:school_wall_app/views/login.dart';

Map<String, WidgetBuilder> route = {
  "/myApp": (BuildContext context) => MyApp(),
  "/login": (BuildContext context) => Login(),
};