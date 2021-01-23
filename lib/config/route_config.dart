import 'package:flutter/material.dart';
import 'package:school_wall_app/app.dart';
import 'package:school_wall_app/views/login.dart';
import 'package:school_wall_app/views/publish/detail/ecard.dart';

class RouteName {
  static const String MY_APP = "/my_app";

  static const String LOGIN = "/login";

  static const String PUBLISH_DETAIL_ECARD = "/publish_detail_Ecard";
}

Map<String, WidgetBuilder> route = {
  RouteName.MY_APP: (BuildContext context) => MyApp(),
  RouteName.LOGIN: (BuildContext context) => Login(),
  RouteName.PUBLISH_DETAIL_ECARD: (BuildContext context) => Ecard(),
};

