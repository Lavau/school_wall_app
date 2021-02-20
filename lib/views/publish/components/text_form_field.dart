import 'package:flutter/material.dart';

TextFormField buildTextFormField(TextEditingController controller, String text,
    {String keyBoardType = "text", int maxLength = 10, int maxLines = 1,
      Function validatorFunc}
    ) {
  return TextFormField(
    maxLength: maxLength,
    maxLines: maxLines,
    keyboardType: "text" == keyBoardType ? TextInputType.text :  TextInputType.number,
    autofocus: true,
    controller: controller,
    decoration: InputDecoration(labelText: text, hintText: "请输入$text"),
    validator: validatorFunc,
  );
}