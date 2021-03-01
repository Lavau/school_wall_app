// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as String,
    promulgatorId: json['promulgatorId'] as String,
    attachedId: json['attachedId'] as String,
    parentId: json['parentId'] as String,
    content: json['content'] as String,
    gmtCreate: json['gmtCreate'] as int,
    avatarUrl: json['avatarUrl'] as String,
    nickname: json['nickname'] as String,
    commentNum: json['commentNum'] as int,
    mine: json['mine'] as bool,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'promulgatorId': instance.promulgatorId,
      'attachedId': instance.attachedId,
      'parentId': instance.parentId,
      'content': instance.content,
      'gmtCreate': instance.gmtCreate,
      'avatarUrl': instance.avatarUrl,
      'nickname': instance.nickname,
      'commentNum': instance.commentNum,
      'mine': instance.mine,
    };
