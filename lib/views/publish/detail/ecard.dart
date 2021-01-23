import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_wall_app/components/my_button.dart';
import 'package:school_wall_app/utils/http_request.dart';
import 'package:school_wall_app/models/college.dart';

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

  TextEditingController _ecardIdController = TextEditingController();
  TextEditingController _stuIdController = TextEditingController();
  TextEditingController _stuNameController = TextEditingController();
  TextEditingController _claimMsgController = TextEditingController();
  GlobalKey _formKey= GlobalKey<FormState>();

  List<College> _collegesInfo = [];
  String _collegeId;

  @override
  initState(){
    super.initState();
    _collegeId = null;
    getDataFromServer();
  }

  getDataFromServer() async {
    String result = await HttpRequest.request("/noLogin/college/list");
    Map<String, dynamic> resultMap = json.decode(result);

    List<College> colleges = [];
    for (var item in resultMap["data"]) {
      colleges.add(College.fromJson(item));
    }

    setState(() => _collegesInfo = colleges);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("一卡通发布")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: _form(),
      ),
    );
  }

  Form _form() {
    RegExp exp = RegExp(r"\D+");

    Function ecardIdValidatorFunc = (value) =>
        exp.hasMatch(value) || value.toString().length != 10 ? "填写有误" : null;
    Function stuIdValidatorFunc = (value) =>
        exp.hasMatch(value) || value.toString().length != 9 ? "填写有误" : null;
    Function numOfWordValidatorFunc = (value) =>
        value.toString().length > 0 ? null : "请填写内容";

    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildTextFormField(_ecardIdController, "一卡通号", validatorFunc: ecardIdValidatorFunc),
            _buildTextFormField(_stuIdController, "学号", maxLength: 9, validatorFunc: stuIdValidatorFunc),
            _buildTextFormField(_stuNameController, "姓名", keyBoardType: "text", maxLength: 50, validatorFunc: numOfWordValidatorFunc),
            _buildTextFormField(_claimMsgController, "认领信息", keyBoardType: "text", maxLength: 50, validatorFunc: numOfWordValidatorFunc),
            _collegesInfo.length == 0 ? Text("获取信息") : _buildCollegeOfDropdownButton(),
            myButton("发布", _deliverDateToServer)
          ],
        ),
      );
  }

  TextFormField _buildTextFormField(TextEditingController controller, String text,
      {String keyBoardType = "number", int maxLength = 10,
        Function validatorFunc}
  ) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: "number" == keyBoardType ? TextInputType.number : TextInputType.text,
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(labelText: text, hintText: "请输入$text"),
      validator: validatorFunc,
    );
  }

  DropdownButton<String> _buildCollegeOfDropdownButton() {
    return DropdownButton(
      value: _collegeId,
      icon: Icon(Icons.arrow_right),
      iconSize: 40,
      hint: Text('请选择学院'),
      isExpanded: true,
      underline: Container(height: 1, color: Colors.grey),
      items: _buildItemsOfDropdownButton(),
      onChanged: (value) {
        setState(() => _collegeId = value.toString());
      }
    );
  }

  List<DropdownMenuItem<String>> _buildItemsOfDropdownButton() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (College college in _collegesInfo) {
      dropdownMenuItems.add(DropdownMenuItem(
        child: Text(college.collegeName),
        value: college.collegeId
      ));
    }
    return dropdownMenuItems;
  }

  void _deliverDateToServer() async {
    if (_collegeId == null) {
      showDialog(context: context, child: AlertDialog(title: Center(child: Text("请选择学院"))));
      return;
    }
    if ((_formKey.currentState as FormState).validate()) {}

    Map params = {
      "ecardId": _ecardIdController.text,
      "stuId": _stuIdController.text,
      "stuName": _stuNameController.text,
      "msg": _claimMsgController.text,
      "collegeId": _collegeId
    };
    String result = await HttpRequest.request("/app/login/ecard/publish", method: "post", params: params);
  }
}