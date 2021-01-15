import 'package:flutter/material.dart';
import 'package:school_wall_app/app.dart';
import 'package:school_wall_app/views/login.dart';
import 'package:school_wall_app/views/publish/detail/ecard.dart';

Map<String, WidgetBuilder> route = {
  "/myApp": (BuildContext context) => MyApp(),
  "/login": (BuildContext context) => Login(),
  "/publish_detail_Ecard": (BuildContext context) => Ecard(),
};

