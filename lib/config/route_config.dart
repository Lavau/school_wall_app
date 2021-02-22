import 'package:flutter/material.dart';
import 'package:school_wall_app/app.dart';
import 'package:school_wall_app/views/home/detail/ecard_detail.dart';
import 'package:school_wall_app/views/home/detail/others_detail.dart';
import 'package:school_wall_app/views/home/detail/visit_replied_comments.dart';
import 'package:school_wall_app/views/login.dart';
import 'package:school_wall_app/views/myself/visit_my_data.dart';
import 'package:school_wall_app/views/publish/detail/publish_ecard.dart';
import 'package:school_wall_app/views/publish/detail/publish_others.dart';

class RouteName {
  static const String MY_APP = "/my_app";

  static const String LOGIN = "/login";

  static const String PUBLISH_DETAIL_ECARD = "/publish_detail_Ecard";

  static const String PUBLISH_DETAIL_OTHERS = "/publish_detail_others";

  static const String SHOW_DETAIL_ECARD = "/show_detail_ecard";

  static const String SHOW_DETAIL_OTHERS = "/show_detail_others";

  static const String VISIT_REPLY_COMMENTS = "/visit_reply_comments";

  static const String VISIT_MY_DATA = "/visit_my_data";
}

Map<String, WidgetBuilder> route = {
  RouteName.MY_APP: (BuildContext context) => MyApp(),
  RouteName.LOGIN: (BuildContext context) => Login(),
  RouteName.PUBLISH_DETAIL_ECARD: (BuildContext context) => PublishEcard(),
  RouteName.PUBLISH_DETAIL_OTHERS: (BuildContext context) => PublishOthers(),
  RouteName.SHOW_DETAIL_ECARD: (BuildContext context) => EcardDetail(),
  RouteName.SHOW_DETAIL_OTHERS: (BuildContext context) => OthersDetail(),
  RouteName.VISIT_REPLY_COMMENTS: (BuildContext context) => VisitRepliedComments(),
  RouteName.VISIT_MY_DATA: (BuildContext context) => VisitMyData(),
};

