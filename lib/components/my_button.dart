import 'package:flutter/material.dart';
import 'package:school_wall_app/config/app_config.dart' as AppConfig;

Container myButton(String buttonText, Function func) {
  return Container(
      margin: EdgeInsets.all(10),
      width: 400,
      decoration: BoxDecoration(border: Border.all(color: AppConfig.PRIMARY_COLOR)),
      child: FlatButton(
          child: Text(buttonText),
          onPressed: func
      )
  );
}