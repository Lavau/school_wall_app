import 'package:flutter/material.dart';

class Publish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布"),
      ),
      body: Center(
        child: Text("发布", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
