import 'package:flutter/material.dart';

class Myself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("个人中心")),
      ),
      body: Center(
        child: Text("我的", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
