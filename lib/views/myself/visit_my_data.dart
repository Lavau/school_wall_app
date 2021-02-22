import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_wall_app/config/app_config.dart' as AppConfig;
import 'package:school_wall_app/config/route_config.dart';
import 'package:school_wall_app/models/type_data.dart';
import 'package:school_wall_app/myenum/type_enum.dart';
import 'package:school_wall_app/utils/date_time_util.dart' as TimeUtil;
import 'package:school_wall_app/utils/http_request.dart';

class VisitMyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int typeId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('我的${_titleOfAppBar(typeId)}')),
      body: VisitMyDataContent(typeId: typeId),
    );
  }

  String _titleOfAppBar(int id) {
    switch (id) {
      case 1: return "发布";
      case 2: return "点赞";
      case 3: return "评论";
      default: return "错误id";
    }
  }
}

class VisitMyDataContent extends StatefulWidget {
  int typeId;

  VisitMyDataContent({this.typeId});

  @override
  _VisitMyDataContentState createState() => _VisitMyDataContentState();
}

class _VisitMyDataContentState extends State<VisitMyDataContent> {

  List<TypeData> _typeDatas;

  @override
  void initState() {
    _typeDatas = null;
    getDataFromServer();
  }

  getDataFromServer() {
    HttpRequest.request("/login/myData", params: {"typeId": widget.typeId}).then((result) {
      Map<String, dynamic> resultMap = json.decode(result);
      List<TypeData> typeDatas = [];
      if (resultMap["success"]) {
        for (var item in resultMap["data"]) {
          typeDatas.add(TypeData.fromJson(item));
        }
        setState(() => _typeDatas = typeDatas);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _typeDatas == null ? Text("加载数据中") :
      _typeDatas.length == 0 ? Text("暂无数据") : ListView.builder(
        itemCount: _typeDatas.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemOfBody(_typeDatas[index]);
        },
    );
  }

  Widget _buildItemOfBody(TypeData typeData) {
    return InkWell(
      child: Column(
        children: [
          _buildTopInfoOfItem(typeData),
          _buildBottomInfoOfItem(typeData),
          Divider(height: 20, color: AppConfig.PRIMARY_COLOR)
        ],),
      onTap: () => _goToDetailPage(typeData)
    );
  }

  void _goToDetailPage(TypeData typeData) {
    if (typeData.typeId == TypeEnum.ECARD_7.index) {
      Navigator.pushNamed(context, RouteName.SHOW_DETAIL_ECARD, arguments: typeData.id);
    } else {
      Map<String, dynamic> arguments = {
        "typeId": typeData.typeId,
        "id": typeData.id
      };
      Navigator.pushNamed(context, RouteName.SHOW_DETAIL_OTHERS, arguments: arguments);
    }
  }

  Widget _buildTopInfoOfItem(TypeData typeData) {
    List<Widget> widgets = [];
    widgets.add(Text(typeData.description, overflow: TextOverflow.fade));
    if (widget.typeId == 1) {
      widgets.add(Icon(Icons.delete_forever, color: AppConfig.PRIMARY_COLOR));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }

  Widget _buildBottomInfoOfItem(TypeData typeData) {
    List<Widget> widgets = [];
    if (typeData.pictureNum > 0) {
      widgets.add(Icon(Icons.photo, color: AppConfig.PRIMARY_COLOR));
    }
    widgets.add(Text(typeData.typeName));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: widgets),
        Text(TimeUtil.dateTimeConvertToString(typeData.gmtCreate),
            style: TextStyle(fontSize: 12)
        )
      ],
    );
  }
}

