import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_wall_app/config/app_config.dart' as AppConfig;
import 'package:school_wall_app/config/route_config.dart';
import 'package:school_wall_app/utils/http_request.dart';

class Myself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("个人中心")),
      ),
      body: MySelfContent(),
    );
  }
}

class MySelfContent extends StatefulWidget {
  @override
  _MySelfContentState createState() => _MySelfContentState();
}

class _MySelfContentState extends State<MySelfContent> {
  Map<String, dynamic> _myInfo;

  @override
  void initState() {
    _myInfo = null;
    getDataFromServer();
  }

  getDataFromServer() {
    HttpRequest.request("/login/myData/info").then((result) {
      Map<String, dynamic> resultMap = json.decode(result);
      setState(() => _myInfo = resultMap["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _myInfo == null ? Text("获取数据中") : Container(
      child: ListView(
        children: _buildWidgetsOfBody(),
      )
    );
  }

  List<Widget> _buildWidgetsOfBody() {
    List<Widget> widgets = [];
    widgets.add(_myInfoCard());
    widgets.add(ListTile(leading: Icon(Icons.assignment, color: AppConfig.PRIMARY_COLOR),
      title: Text("我发布的"),
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, RouteName.VISIT_MY_DATA, arguments: 1)
    ));
    widgets.add(Divider(height: 20, color: AppConfig.PRIMARY_COLOR));
    widgets.add(ListTile(leading: Icon(Icons.favorite_border, color: AppConfig.PRIMARY_COLOR),
      title: Text("我点赞的"),
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, RouteName.VISIT_MY_DATA, arguments: 2)
    ));
    widgets.add(Divider(height: 20, color: AppConfig.PRIMARY_COLOR));
    widgets.add(ListTile(leading: Icon(Icons.comment, color: AppConfig.PRIMARY_COLOR),
      title: Text("我评论的"),
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, RouteName.VISIT_MY_DATA, arguments: 3)
    ));
    return widgets;
  }

  Widget _myInfoCard() {
    return Container(
      height: 120,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        color: AppConfig.PRIMARY_COLOR
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              child: Image.network(_myInfo["avatarUrl"]),
              width: 50.0,
              height: 50.0,
            ),
          ),
          SizedBox(width: 8),
          Text("${_myInfo['nickname']}",
              style: TextStyle(fontSize: 20)
          )
        ],
    ));
  }
}

