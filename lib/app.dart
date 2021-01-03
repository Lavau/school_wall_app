import 'package:flutter/material.dart';
import 'config/app_config.dart' as AppConfig;
import 'views/home/home.dart';
import 'views/publish/publish.dart';
import 'views/myself/myself.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "校园生活JIA",
      theme: ThemeData(
        primaryColor: AppConfig.PRIMARY_COLOR,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent
      ),
      home: MyStackPage(),
    );
  }
}

class MyStackPage extends StatefulWidget {
  @override
  _MyStackPageState createState() => _MyStackPageState();
}

class _MyStackPageState extends State<MyStackPage> {

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          createItem("home", "首页"),
          createItem("publish", "发布"),
          createItem("myself", "我的"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Home(),
          Publish(),
          Myself()
        ],
      ),
    );
  }
}

BottomNavigationBarItem createItem(String iconName, String title) {
  return BottomNavigationBarItem(
      icon: Image.asset("assets/images/tabbar/$iconName.png", width: 30,),
      activeIcon: Image.asset("assets/images/tabbar/${iconName}-active.png", width: 30,),
      title: Text(title)
  );
}


