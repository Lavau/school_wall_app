import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_wall_app/config/app_config.dart' as AppConfig;
import 'package:school_wall_app/config/route_config.dart';
import 'package:school_wall_app/utils/http_request.dart';

void obtainLoginStatus() async {
  String result = await HttpRequest.request("/noLogin/isLogin");
  AppConfig.isLogin = json.decode(result)["data"];
}


showLoginDialog(BuildContext context) {
  if (AppConfig.isLogin == false) {
    showDialog(context: context,
        child: AlertDialog(
          title: Text("提示"),
          content: Text("您未登录，是否前往登录页？"),
          actions: <Widget>[
            FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.pop(context)
            ),
            FlatButton(
                child: Text("确定"),
                onPressed: () => Navigator.pushNamed(context, RouteName.LOGIN)
            ),
          ],
        )
    );
  }
}