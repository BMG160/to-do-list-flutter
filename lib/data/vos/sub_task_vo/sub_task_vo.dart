import 'package:json_annotation/json_annotation.dart';

part 'sub_task_vo.g.dart';

@JsonSerializable()
class SubTaskVO{

  @JsonKey(name: 'sub_task_id')
  String? subTaskID;

  @JsonKey(name: 'sub_task')
  String? subTask;

  @JsonKey(name: 'order')
  int? order;

  @JsonKey(name: 'task_status')
  bool? taskStatus;

  @JsonKey(name: 'main_task_id')
  String? mainTaskID;

  @JsonKey(name: 'user_id')
  String? userID;

  SubTaskVO(this.subTaskID, this.subTask, this.order, this.taskStatus,
      this.mainTaskID, this.userID);

  factory SubTaskVO.fromJson(Map<String, dynamic> json) => _$SubTaskVOFromJson(json);

  Map<String, dynamic> toJson() => _$SubTaskVOToJson(this);
}