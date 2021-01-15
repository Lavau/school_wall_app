import 'package:flutter/material.dart';
import 'package:school_wall_app/config/http_request.dart';
import 'package:school_wall_app/models/type_data.dart';
import 'package:school_wall_app/myenum/type_enum.dart';
import 'package:school_wall_app/config/app_config.dart' as AppConfig;
import 'package:school_wall_app/utils/date_time_util.dart' as TimeUtil;
import 'dart:convert';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("校园生活JIA"),
      ),
      body: Center(
        child: HomeContent(),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  
  List<TypeData> _showListOfTypeData = [];
  int _currentPageNum;
  int _totalPages;

  @override
  initState(){
    super.initState();
    getDataFromServer();
  }

  // 准备在页面上显示的数据
  getDataFromServer() async {
    String result = await HttpRequest.request("/noLogin/index");
    Map<String, dynamic> resultMap = json.decode(result);
    _currentPageNum = resultMap["data"]["pageNum"];
    _totalPages = resultMap["data"]["pages"];
    for (var item in resultMap["data"]["list"]) {
      _showListOfTypeData.add(TypeData.fromJson(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _showListOfTypeData.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildContainer(index);
      },
    );
  }

  Container _buildContainer(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: EdgeInsets.all(5),
      decoration: _boxDecoration(),
      child: Column(
        children: _columnChildrenOfListView(_showListOfTypeData[index]),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color.fromRGBO(240, 239, 245, 1),
          width: 30
        )
      )
    );
  }

  List<Widget> _columnChildrenOfListView(TypeData typeData) {
    if (typeData.typeId == TypeEnum.ECARD_7.index) {
      return _renderTypeEcardOfColumnChildren(typeData);
    } else {
      return _renderTypeOthersOfColumnChildren(typeData);
    }
  }

  List<Widget> _renderTypeEcardOfColumnChildren(TypeData typeData) {
    List<Widget> widgetOfBunch = [];
    widgetOfBunch.add(_iconAndTitleOfLabel("一卡通认领"));
    widgetOfBunch.add(_listTile("学院", typeData.title));
    widgetOfBunch.add(_listTile("学号", typeData.stuId));
    widgetOfBunch.add(_listTile("姓名", typeData.description));
    return widgetOfBunch;
  }

  ListTile _iconAndTitleOfLabel(String titleText) {
    return ListTile(
        leading: Icon(Icons.bookmark_border, color: AppConfig.PRIMARY_COLOR),
        title: Text(titleText, style: TextStyle(color: AppConfig.PRIMARY_COLOR))
      );
  }

  ListTile _listTile(String leadingText, String titleText) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      leading: Text(leadingText),
      title: Text(titleText)
    );
  }

  List<Widget> _renderTypeOthersOfColumnChildren(TypeData typeData) {
    List<Widget> widgetOfBunch = [];

    if (typeData.pictureNum > 0) {
      _incrementPicturesWidget(typeData, widgetOfBunch);
    }

    if (typeData.description.length > 0) {
      widgetOfBunch.add(Text(typeData.description,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16))
      );
    }

    if (typeData.description.length == 0 && typeData.title.length > 0) {
      widgetOfBunch.add(Text(typeData.title));
    }

    widgetOfBunch.add(_iconAndTitleOfLabel(typeData.typeName));

    Widget bottomColumn = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _promulgatorInfo(typeData),
        _viewInfoAndPromulgatorTime(typeData)
      ],
    );
    widgetOfBunch.add(bottomColumn);

    return widgetOfBunch;
  }

  Column _viewInfoAndPromulgatorTime(TypeData typeData) {
    return Column(
      children: [
        Text("${typeData.viewNum} 浏览", style: TextStyle(fontSize: 12),),
        Text(TimeUtil.dateTimeConvertToString(typeData.gmtCreate),
          style: TextStyle(fontSize: 12)
        )
      ],
    );
  }

  Widget _promulgatorInfo(TypeData typeData) {
    Image avatar = typeData.anonymous ?
        Image.asset("assets/images/home/anonymity.png") : Image.network(typeData.avatarUrl);
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
        Text("${typeData.anonymous ? '匿名' : typeData.nickname}",
          style: TextStyle(fontSize: 15)
        )
      ],
    );
  }

  void _incrementPicturesWidget(TypeData typeData, List<Widget> widgetOfBunch) {
    List<Widget> pictures = [];
    for (int i = 0; i < typeData.pictureUrlList.length; i++) {
      pictures.add(Image.network(typeData.pictureUrlList[i], height: 100, width: 100,));
    }
    Widget picturesOfRow = Row(
      children: pictures,
    );
    widgetOfBunch.add(picturesOfRow);
  }
}

