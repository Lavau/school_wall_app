import 'package:flutter/material.dart';

class Ecard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EcardContent();
  }
}

class EcardContent extends StatefulWidget {
  @override
  _EcardContentState createState() => _EcardContentState();
}

class _EcardContentState extends State<EcardContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("一卡通发布页")),
      body: Center(child: Text('一卡通发布页')),
    );
  }
}

