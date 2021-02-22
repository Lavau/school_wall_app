import 'dart:convert';

import "package:flutter/material.dart";
import 'package:school_wall_app/config/app_config.dart' as AppConfig;
import 'package:school_wall_app/config/route_config.dart';
import 'package:school_wall_app/models/comment.dart';
import 'package:school_wall_app/utils/date_time_util.dart' as TimeUtil;
import 'package:school_wall_app/utils/http_request.dart';

class ShowCommentsOfTypeData extends StatefulWidget {
  String attachedId;
  
  ShowCommentsOfTypeData({this.attachedId});
  
  @override
  _ShowCommentsOfTypeDataState createState() => _ShowCommentsOfTypeDataState();
}

class _ShowCommentsOfTypeDataState extends State<ShowCommentsOfTypeData> {
  TextEditingController _commentEditingController = TextEditingController();
  GlobalKey _formKey= GlobalKey<FormState>();

  List<Comment> _comments;

  @override
  void initState() {
    _comments = [];
    getCommentsFromServer();
  }

  getCommentsFromServer() async {
    HttpRequest.request("/login/comment/list/typeData", params: {"attachedId": widget.attachedId}).then((result) {
      Map<String, dynamic> resultMap = json.decode(result);
      print(result);
      List<Comment> comments = [];
      if (resultMap["success"]) {
        for (var comment in resultMap["data"]) {
          comments.add(Comment.fromJson(comment));
        }
      }
      setState(() => _comments = comments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _comments.length == 0 ? Text("快来评论吧") : Column(
      children: _buildCommentItems());
  }

  List<Widget> _buildCommentItems() {
    List<Widget> commentItems = [];
    for (Comment comment in _comments) {
      commentItems.add(_buildCommentItem(comment));
    }
    return commentItems;
  }

  Widget _buildCommentItem(Comment comment) {
    List<Widget> widgets = [];
    widgets.add(Text(comment.content));
    widgets.add(_publishTimeAndOperatorsOfComment(comment));
    if (comment.commentNum > 0) {
      widgets.add(_showCommentNumAndVisitReplyComments(comment));
    } else {
      widgets.add(Divider(height: 25, color: Color.fromRGBO(214, 234, 245, 1)));
    }

    return Column(
      children: [
        _promulgatorInfo(comment),
        Container(
          margin: EdgeInsets.fromLTRB(35, 0, 10, 0),
          child: Column(
            children: widgets
          )
        )
      ],
    );
  }

  Widget _promulgatorInfo(Comment comment) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            child: Image.network(comment.avatarUrl),
            width: 30.0,
            height: 30.0,
          ),
        ),
        Text("${comment.nickname}",
            style: TextStyle(fontSize: 15)
        )
      ],
    );
  }

  Widget _publishTimeAndOperatorsOfComment(Comment comment) {
    List<Widget> widgets = [];

    Text publishTime = Text(TimeUtil.dateTimeConvertToString(comment.gmtCreate),
        style: TextStyle(fontSize: 12));
    widgets.add(publishTime);

    _commentOperators(widgets, comment);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets
    );
  }

  void _commentOperators(List<Widget> widgets, Comment comment) {
    widgets.add(InkWell(
        child: Text("回复"),
        onTap: () => _replyComment(comment)
      )
    );
    if (comment.mine) {
      widgets.add(InkWell(
          child: Text("删除"),
          onTap: () => _deleteComment(comment)
          )
      );
    }
  }

  _replyComment(Comment comment) {
    _inputAndPublishComment(comment);
  }

  _deleteComment(Comment comment) {
    HttpRequest.request("/login/comment/delete/typeData", params: {"parentId": comment.id}).then((result) {
      Map<String, dynamic> resultMap = json.decode(result);
      if (resultMap["success"]) {
        showDialog(context: context, child: AlertDialog(title: Text("删除评论成功")));
      } else {
        showDialog(context: context, child: AlertDialog(title: Text("评论不存在或已被删除")));
      }
    });
  }

  Widget _showCommentNumAndVisitReplyComments(Comment comment) {
    return InkWell(
      child: Column(
        children: [
          Container(
            width: 500,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 239, 245, 1),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Text("${comment.commentNum}条回复", textAlign: TextAlign.center,),
            ),
          Divider(height: 25, color: Color.fromRGBO(241, 245, 247, 1))
        ]),
      onTap: () => Navigator.pushNamed(context, RouteName.VISIT_REPLY_COMMENTS, arguments: comment.id)
    );
  }

  _inputAndPublishComment(Comment comment) {
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
              Container(
                  margin: EdgeInsets.all(10),
                  width: 400,
                  decoration: BoxDecoration(border: Border.all(color: AppConfig.PRIMARY_COLOR)),
                  child: FlatButton(
                      child: Text("发布"),
                      onPressed: () => sendCommentToServer(comment)
                  )
              )
            ],
          );
        }
    );
  }

  sendCommentToServer(Comment comment) {
    if (!(_formKey.currentState as FormState).validate()) {
      return;
    }

    Map<String, dynamic> params = {
      "commentContent": _commentEditingController.text, "parentId": comment.id};
    HttpRequest.request("/login/comment/reply/insert", params: params).then((result) {
      Map<String, dynamic> resultMap = json.decode(result);
      if (resultMap["success"]) {
        showDialog(context: context, child: AlertDialog(title: Text("回复评论成功")));
      } else {
        showDialog(context: context, child: AlertDialog(title: Text("父评论不存在或已被删除")));
      }
    });
  }

}
