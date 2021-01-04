import 'package:json_annotation/json_annotation.dart';

// college.g.dart 将在我们运行生成命令后自动生成
part 'index.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class Index{
  Index(this.anonymous, this.avatarUrl, this.description, this.gmtCreate,
      this.id, this.nickname, this.pictureNum, this.promulgatorId, this.title,
      this.typeId, this.typeName, this.viewNum);

  bool anonymous;
  String avatarUrl;
  String description;
  DateTime gmtCreate;
  String id;
  String nickname;
  int pictureNum;
  String promulgatorId;
  String title;
  int typeId;
  String typeName;
  int viewNum;

  //不同的类使用不同的mixin即可
  factory Index.fromJson(Map<String, dynamic> json) => _$IndexFromJson(json);
  Map<String, dynamic> toJson() => _$IndexToJson(this);
}