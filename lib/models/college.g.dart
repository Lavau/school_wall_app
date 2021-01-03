// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

College _$CollegeFromJson(Map<String, dynamic> json) {
  return College(
    json['collegeId'] as String,
    json['collegeName'] as String,
  );
}

Map<String, dynamic> _$CollegeToJson(College instance) => <String, dynamic>{
      'collegeId': instance.collegeId,
      'collegeName': instance.collegeName,
    };
