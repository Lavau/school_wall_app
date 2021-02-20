import 'package:json_annotation/json_annotation.dart';

// college.g.dart 将在我们运行生成命令后自动生成
part 'type_data.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class TypeData{
  TypeData(this.anonymous, this.avatarUrl, this.description, this.gmtCreate,
      this.id, this.nickname, this.pictureNum, this.promulgatorId, this.title,
      this.typeId, this.typeName, this.viewNum, this.pictureUrlList, this.stuId,
      this.likeNum, this.commentNum, this.like, this.msg, this.contactInformation,
      this.height, this.interest, this.speciality, this.weight);

  bool anonymous;
  String avatarUrl;
  String description;
  int gmtCreate;
  String id;
  String nickname;
  int pictureNum;
  String promulgatorId;
  String title;
  String stuId;
  int typeId;
  String typeName;
  int viewNum;
  List<String> pictureUrlList;

  int likeNum;
  int commentNum;
  bool like;
  String msg;

  String contactInformation;
  double height;
  double weight;
  String speciality;
  String interest;

  //不同的类使用不同的mixin即可
  factory TypeData.fromJson(Map<String, dynamic> json) => _$TypeDataFromJson(json);
  Map<String, dynamic> toJson() => _$TypeDataToJson(this);
}