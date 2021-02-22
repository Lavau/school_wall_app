import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_wall_app/components/my_button.dart';
import 'package:school_wall_app/models/type_data.dart';
import 'package:school_wall_app/utils/http_request.dart';

class LikeAndCommentAndShowSomeInfo extends StatefulWidget {

  TypeData typeData;

  LikeAndCommentAndShowSomeInfo({this.typeData});

  @override
  _LikeAndCommentAndShowSomeInfoState createState() => _LikeAndCommentAndShowSomeInfoState();
}

class _LikeAndCommentAndShowSomeInfoState extends State<LikeAndCommentAndShowSomeInfo> {
  TextEditingController _commentEditingController = TextEditingController();
  GlobalKey _formKey= GlobalKey<FormState>();

  bool _isLike;
  int _likeNum;

  @override
  void initState() {
    _isLike = widget.typeData.like;
    _likeNum = widget.typeData.likeNum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(240, 239, 245, 1),
                  width: 30
              )
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _likeAndComment(),
          _showSomeInfo()
        ],
    ));
  }

  Widget _likeAndComment() {
    IconData likeIcon = _isLike ? Icons.favorite : Icons.favorite_border;

    return Row(
      children: [
        InkWell(
          child: Icon(likeIcon),
          onTap: () => _dealWithLike(!_isLike),
        ),
        InkWell(
          child: Icon(Icons.comment),
          onTap: () => _inputAndPublishComment(),
        )
      ],
    );
  }

  _dealWithLike(bool isLike) {
    setState(() {
      _isLike = isLike;
      _likeNum = _isLike ? _likeNum + 1 : _likeNum - 1;
    });
    Map<String, dynamic> params = {"isLike": isLike, "id": widget.typeData.id};
    HttpRequest.request("/login/others/like", params: params).then((result) {
      Map<String, dynamic> resultMap = json.decode(result);
      if (resultMap["success"]) {
        showDialog(context: context, child: AlertDialog(title: Text("${isLike ? '点赞' : '取消点赞'}成功")));
      }
    });
  }

  _inputAndPublishComment() {
    showModalBottomSheet<int>(
      context: context,
      backgroundColor: Color(0x000), // 背景色设置为无色
      elevation: 2, // 透明度
      builder: (BuildContext context) {
        return Column(
          children: [
            Form(
                key: _formKey,
                child: TextFormField(
                  controller: _commentEditingController,
                  decoration: InputDecoration(fillColor: Colors.white,
                      labelText: '评论',
                      hintText: "请输入友善的评论"
                  ),
                  maxLength: 200,
                  maxLines: 4,
                  validator: (value) => value.length == 0 ? "评论为空，请输入" : null,
                )
            ),
            myButton("发布", sendCommentToServer)
          ],
        );
      }
    );
  }

  sendCommentToServer() {
    if (!(_formKey.currentState as FormState).validate()) {
      return;
    }

    Map<String, dynamic> params = {
      "commentContent": _commentEditingController.text, "attachedId": widget.typeData.id};
    HttpRequest.request("/login/comment/insert", params: params).then((result) {
      Map<String, dynamic> resultMap = json.decode(result);
      if (resultMap["success"]) {
        showDialog(context: context, child: AlertDialog(title: Text("评论成功")));
      } else {
        showDialog(context: context, child: AlertDialog(title: Text("该记录不存在或已被删除")));
      }
    });
  }

  Widget _showSomeInfo() {
    return Text("${_likeNum}点赞 | ${widget.typeData.viewNum}浏览");
  }
}
