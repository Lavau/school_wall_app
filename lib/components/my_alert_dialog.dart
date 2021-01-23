import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String content,
{bool showCancel = false,
 Function funcOfCancelButton,
 @required Function funcOfSureButton}) {
    showDialog(context: context,
        child: AlertDialog(
          title: Text("提示"),
          content: Text(content),
          actions: <Widget>[
            showCancel ? null : FlatButton(
                child: Text("取消"),
                onPressed: funcOfCancelButton
            ),
            funcOfSureButton == null ? null : FlatButton(
                child: Text("确定"),
                onPressed: funcOfSureButton
            ),
          ],
        )
    );
}