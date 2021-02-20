import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_wall_app/models/type_data.dart';
import 'package:school_wall_app/myenum/type_enum.dart';
import 'package:school_wall_app/utils/date_time_util.dart' as TimeUtil;
import 'package:school_wall_app/utils/http_request.dart';

class OthersDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("${_getTypeNameByTypeId(arguments['typeId'])} 详情")),
      body: OthersDetailContent(arguments: arguments),
    );
  }

  String _getTypeNameByTypeId(int typeId) {
    if (typeId == TypeEnum.PERSONAL_PUBLICITY_1.index) return "宣传";
    if (typeId == TypeEnum.THANK_OR_RIDICULE_3.index) return "感谢 / 吐槽";
    if (typeId == TypeEnum.LOST_AND_FOUND_4.index) return "失物招领";
    if (typeId == TypeEnum.SEEK_HELP_5.index) return "求助";
    if (typeId == TypeEnum.SINGLE_6.index) return "脱单";
    else return "错误";
  }
}

class OthersDetailContent extends StatefulWidget {
  Map<String, dynamic> arguments;

  OthersDetailContent({this.arguments});

  @override
  _OthersDetailContentState createState() => _OthersDetailContentState();
}

class _OthersDetailContentState extends State<OthersDetailContent> {
  
  TypeData _typeData;
  bool _success;

  @override
  void initState() {
    _success = null;
    _typeData = null;
    getDetailInfoOfOthersFromServer();
  }

  getDetailInfoOfOthersFromServer() async {
    String result = await HttpRequest.request("/login/others/detail", params: widget.arguments);
    print(result);
    Map<String, dynamic> resultMap = json.decode(result);
    setState(() {
      _success = resultMap["success"];
      _typeData = TypeData.fromJson(resultMap["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoding = _success == null;
    Widget showContent = isLoding ? Text("正在加载数据") : _bodyOfOthers();
    return showContent;
  }

  Widget _bodyOfOthers() {
    return Container(
      child: ListView(
        children: [
          _promulgatorInfoAndPromulgatorDate(),
          _typeData.typeId == TypeEnum.SINGLE_6.index ? _singlePersonInfo() : _titleInfo(),
          _showDescription()
        ],
      ),
    );
  }

  Widget _promulgatorInfoAndPromulgatorDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _promulgatorInfo(),
        Text(TimeUtil.dateTimeConvertToString(_typeData.gmtCreate),
            style: TextStyle(fontSize: 12)
        )
      ],
    );
  }

  Widget _promulgatorInfo() {
    Image avatar = _typeData.anonymous ?
    Image.asset("assets/images/home/anonymity.png") : Image.network(_typeData.avatarUrl);
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            child: avatar,
            width: 30.0,
            height: 30.0,
          ),
        ),
        SizedBox(width: 8,),
        Text("${_typeData.anonymous ? '匿名' : _typeData.nickname}",
            style: TextStyle(fontSize: 15)
        )
      ],
    );
  }

  Widget _singlePersonInfo() {
    return Column(
      children: [
        ListTile(leading: Text("身高"), title: Text("${_typeData.height}")),
        ListTile(leading: Text("体重"), title: Text("${_typeData.weight}")),
        ListTile(leading: Text("特长"), title: Text("${_typeData.speciality}")),
        ListTile(leading: Text("爱好"), title: Text("${_typeData.interest}")),
      ],
    );
  }

  Widget _titleInfo() {
    String leadingText = _typeData.typeId == TypeEnum.LOST_AND_FOUND_4.index ? "物品" : "主题";
    return ListTile(
      leading: Text("$leadingText :"),
      title: Text(_typeData.title)
    );
  }

  Widget _showDescription() {
    return Column(
      children: [
        ListTile(leading: Text("具体描述")),
        Text("${_typeData.description}")
      ],
    );
  }
}
