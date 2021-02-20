import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_wall_app/components/my_button.dart';
import 'package:school_wall_app/models/ecard.dart';
import 'package:school_wall_app/utils/http_request.dart';

class EcardDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;

    print("$id");
    return Scaffold(
      appBar: AppBar(title: Text("一卡通详情")),
      body: EcardDetailContent(id: id),
    );
  }
}

class EcardDetailContent extends StatefulWidget {
  String id;

  EcardDetailContent({this.id});

  @override
  _EcardDetailContentState createState() => _EcardDetailContentState();
}

class _EcardDetailContentState extends State<EcardDetailContent> {

  TextEditingController _ecardIdEditingController = TextEditingController();
  GlobalKey _formKey= GlobalKey<FormState>();

  Ecard _ecard;
  bool _isClaim;

  @override
  void initState() {
    _ecard = null;
    _isClaim = null;
    getDetailInfoOfEcardFromServer();
  }

  getDetailInfoOfEcardFromServer() async {
    String result = await HttpRequest.request("/login/ecard/detail", params: {"id": widget.id});
    Map<String, dynamic> resultMap = json.decode(result);
    setState(() {
      _isClaim = resultMap["success"];
      _ecard = _isClaim ? Ecard.fromJson(resultMap["data"]) : null;
      print("${_ecard.id}, ${_ecard.gmtClaim}");
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoding = _ecard == null && _isClaim == null;
    Widget showContent = isLoding ? Text("正在加载数据") : _bodyOfEcard();
    return showContent;
  }

  Widget _bodyOfEcard() {
    return !_isClaim ? Center(child: Text("该一卡通已被认领")) :
      Container(
        child: ListView(
          children: [
            _ecardInfo(),
            _alertInfo(),
            _claimPart()
          ],
        ),
    );
  }

  Widget _ecardInfo() {
    return Column(
      children: [
        Text(_ecard.stuName),
        Text(_ecard.stuId),
        Text(_ecard.college)
      ],
    );
  }

  Widget _alertInfo() {
    return Text("请仔细检查信息，填写一卡通后认领。有问题联系管理员");
  }

  Widget _claimPart() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _ecardIdEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: '一卡通号', hintText: "请输入一卡通号"),
            maxLength: 10,
            validator: (value) => (RegExp(r"\D+").hasMatch(value)
              || value.toString().length != 10) ? "填写不规范，请重填" : null,
        )),
        myButton("认领", _dealWithClaimEcardId)
      ],
    );
  }

  void _dealWithClaimEcardId() {
    if (!(_formKey.currentState as FormState).validate()) {
      return;
    }

    String ecardIdFromApp = _ecardIdEditingController.text;

    if (ecardIdFromApp != _ecard.ecardId) {
      showDialog(context: context, child: AlertDialog(title: Text('填写的一卡通号错误')));
    } else {
      _sendEcardIdInfoToServer().then((resultMap) {
        if (resultMap["success"]) {
          showDialog(context: context, child: AlertDialog(title: Text(_ecard.msg)));
        } else {
          showDialog(context: context, child: AlertDialog(title: Text('该一卡通已被认领')));
        }
      });
    }
  }

  Future<Map<String, dynamic>> _sendEcardIdInfoToServer() async {
    Map<String, dynamic> params = {
      "id": _ecard.id
    };
    String result = await HttpRequest.request("/login/ecard/claim", params: params);
    return json.decode(result);
  }
}


