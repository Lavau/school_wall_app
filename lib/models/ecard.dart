import 'package:json_annotation/json_annotation.dart';

// college.g.dart 将在我们运行生成命令后自动生成
part 'ecard.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class Ecard {

  Ecard(this.id, this.college, this.stuId, this.stuName,
      this.ecardId, this.msg, this.gmtCreate, this.gmtClaim);

  String id;
  String college;
  String stuId;
  String stuName;
  String ecardId;
  String msg;
  int gmtCreate;
  int gmtClaim;

  //不同的类使用不同的mixin即可
  factory Ecard.fromJson(Map<String, dynamic> json) => _$EcardFromJson(json);
  Map<String, dynamic> toJson() => _$EcardToJson(this);
}