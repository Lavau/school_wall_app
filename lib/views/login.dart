import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_wall_app/components/my_button.dart';
import 'package:school_wall_app/config/app_config.dart' as AppConfig;
import 'package:school_wall_app/config/route_config.dart' as RouteConfig;
import 'package:school_wall_app/utils/http_request.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Center(
        child: LoginContent(),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {

  TextEditingController _stuIdTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();

  GlobalKey _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 120, horizontal: 20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: _buildChildWidgetsOfForm(),
        ),
      ),
    );
  }

  List<Widget> _buildChildWidgetsOfForm() {
    List<Widget> widgets = [];

    TextFormField stuIdTextFormField =  TextFormField(
      maxLength: 9,
      keyboardType: TextInputType.number,
      autofocus: true,
      controller: _stuIdTextEditingController,
      decoration: _inputDecoration("学号", Icons.person),
      validator: (value) => value.length == 9 || RegExp(r"\D+").hasMatch(value)
                  ? null : "填写有误",
    );
    TextFormField passwordTextFormField =  TextFormField(
      maxLength: 8,
      keyboardType: TextInputType.visiblePassword,
      autofocus: true,
      controller: _passwordTextEditingController,
      decoration: _inputDecoration("密码", Icons.lock),
      validator: (value) => value.length >= 8 ? null : "请填写密码",
    );

    widgets.add(stuIdTextFormField);
    widgets.add(passwordTextFormField);
    widgets.add(myButton("登录", _deliverDateToServer));

    return widgets;
  }

  InputDecoration _inputDecoration(String text, IconData icon) =>
      InputDecoration(labelText: "$text", hintText: "请输入$text", icon: Icon(icon));

  _deliverDateToServer() async {
    if ((_formKey.currentState as FormState).validate()) {}

    Map<String, dynamic> params = {
      "stuId": _stuIdTextEditingController.text,
      "password": _passwordTextEditingController.text,
    };
    String result = await HttpRequest.request("/noLogin/login", method: "post", params: params);
    Map<String, dynamic> resultMap = json.decode(result);
    
    if (resultMap["code"].contains("W0602")) {
      AppConfig.isLogin = true;
      Navigator.popAndPushNamed(context, RouteConfig.RouteName.MY_APP);
    } else if (resultMap["code"].contains("W0603")) {
      showDialog(context: context, child: AlertDialog(content: Text(resultMap["msg"])));
    } else {
      showDialog(context: context, child: AlertDialog(content: Text("网络异常")));
    }
  }
}