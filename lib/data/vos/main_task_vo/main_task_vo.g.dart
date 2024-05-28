// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_task_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainTaskVO _$MainTaskVOFromJson(Map<String, dynamic> json) => MainTaskVO(
      json['main_task_id'] as String?,
      json['task'] as String?,
      json['date'] as String?,
      (json['color'] as num?)?.toInt(),
      (json['order'] as num?)?.toInt(),
      json['user_id'] as String?,
    );

Map<String, dynamic> _$MainTaskVOToJson(MainTaskVO instance) =>
    <String, dynamic>{
      'main_task_id': instance.mainTaskID,
      'task': instance.task,
      'date': instance.date,
      'color': instance.color,
      'order': instance.order,
      'user_id': instance.userID,
    };
