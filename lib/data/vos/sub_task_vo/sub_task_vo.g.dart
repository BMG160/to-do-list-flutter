// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubTaskVO _$SubTaskVOFromJson(Map<String, dynamic> json) => SubTaskVO(
      json['sub_task_id'] as String?,
      json['sub_task'] as String?,
      (json['order'] as num?)?.toInt(),
      json['task_status'] as bool?,
      json['main_task_id'] as String?,
      json['user_id'] as String?,
    );

Map<String, dynamic> _$SubTaskVOToJson(SubTaskVO instance) => <String, dynamic>{
      'sub_task_id': instance.subTaskID,
      'sub_task': instance.subTask,
      'order': instance.order,
      'task_status': instance.taskStatus,
      'main_task_id': instance.mainTaskID,
      'user_id': instance.userID,
    };
