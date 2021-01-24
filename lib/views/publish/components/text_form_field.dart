import 'package:flutter/material.dart';

TextFormField buildTextFormField(TextEditingController controller, String text,
    {String keyBoardType = "number", int maxLength = 10, int maxLines = 1,
      Function validatorFunc}
    ) {
  return TextFormField(
    maxLength: maxLength,
    maxLines: maxLines,
    keyboardType: "number" == keyBoardType ? TextInputType.number : TextInputType.text,
    autofocus: true,
    controller: controller,
    decoration: InputDecoration(labelText: text, hintText: "请输入$text"),
    validator: validatorFunc,
  );
}