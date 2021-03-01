// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeData _$TypeDataFromJson(Map<String, dynamic> json) {
  return TypeData(
    json['anonymous'] as bool,
    json['avatarUrl'] as String,
    json['description'] as String,
    json['gmtCreate'] as int,
    json['id'] as String,
    json['nickname'] as String,
    json['pictureNum'] as int,
    json['promulgatorId'] as String,
    json['title'] as String,
    json['typeId'] as int,
    json['typeName'] as String,
    json['viewNum'] as int,
    (json['pictureUrlList'] as List)?.map((e) => e as String)?.toList(),
    json['stuId'] as String,
    json['likeNum'] as int,
    json['commentNum'] as int,
    json['like'] as bool,
    json['msg'] as String,
    json['contactInformation'] as String,
    (json['height'] as num)?.toDouble(),
    json['interest'] as String,
    json['speciality'] as String,
    (json['weight'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TypeDataToJson(TypeData instance) => <String, dynamic>{
      'anonymous': instance.anonymous,
      'avatarUrl': instance.avatarUrl,
      'description': instance.description,
      'gmtCreate': instance.gmtCreate,
      'id': instance.id,
      'nickname': instance.nickname,
      'pictureNum': instance.pictureNum,
      'promulgatorId': instance.promulgatorId,
      'title': instance.title,
      'stuId': instance.stuId,
      'typeId': instance.typeId,
      'typeName': instance.typeName,
      'viewNum': instance.viewNum,
      'pictureUrlList': instance.pictureUrlList,
      'likeNum': instance.likeNum,
      'commentNum': instance.commentNum,
      'like': instance.like,
      'msg': instance.msg,
      'contactInformation': instance.contactInformation,
      'height': instance.height,
      'weight': instance.weight,
      'speciality': instance.speciality,
      'interest': instance.interest,
    };
