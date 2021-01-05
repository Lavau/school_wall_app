import 'package:flutter/material.dart';
import 'package:school_wall_app/config/http_request.dart';
import 'package:school_wall_app/models/index.dart';

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

  List<Index> _list;
  int _pageNum;
  int _pages;

  String text = "wu";

  @override
  initState(){
    super.initState();
    data();
  }

  data() async {
    print((await HttpRequest.request("/noLogin/index")));
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text),);
  }

  Widget _dialog(BuildContext context) {
    return AlertDialog(
      title: Text("请登录"),
      actions: <Widget>[
        FlatButton(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pushReplacementNamed("/myApp"),
        ),
        FlatButton(
          child: Center(child: Text("确定")),
          onPressed: () {
            print("点击确定");
            Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
          },
        ),
      ],
    );
  }
}

