// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ecard _$EcardFromJson(Map<String, dynamic> json) {
  return Ecard(
    json['id'] as String,
    json['college'] as String,
    json['stuId'] as String,
    json['stuName'] as String,
    json['ecardId'] as String,
    json['msg'] as String,
    json['gmtCreate'] as int,
    json['gmtClaim'] as int,
  );
}

Map<String, dynamic> _$EcardToJson(Ecard instance) => <String, dynamic>{
      'id': instance.id,
      'college': instance.college,
      'stuId': instance.stuId,
      'stuName': instance.stuName,
      'ecardId': instance.ecardId,
      'msg': instance.msg,
      'gmtCreate': instance.gmtCreate,
      'gmtClaim': instance.gmtClaim,
    };
