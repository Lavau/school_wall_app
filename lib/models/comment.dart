import 'package:json_annotation/json_annotation.dart';

// college.g.dart 将在我们运行生成命令后自动生成
part 'comment.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class Comment{
  Comment({this.id, this.promulgatorId, this.attachedId, this.parentId, this.content,
    this.gmtCreate, this.avatarUrl, this.nickname, this.commentNum, this.mine});

  String id;
  String promulgatorId;
  String attachedId;
  String parentId;
  String content;
  int gmtCreate;
  String avatarUrl;
  String nickname;
  int commentNum;
  bool mine;

  //不同的类使用不同的mixin即可
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}