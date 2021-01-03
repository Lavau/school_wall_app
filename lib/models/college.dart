import 'package:json_annotation/json_annotation.dart';

// college.g.dart 将在我们运行生成命令后自动生成
part 'college.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class College{
  College(this.collegeId, this.collegeName);

  String collegeId;
  String collegeName;

  //不同的类使用不同的mixin即可
  factory College.fromJson(Map<String, dynamic> json) => _$CollegeFromJson(json);
  Map<String, dynamic> toJson() => _$CollegeToJson(this);
}