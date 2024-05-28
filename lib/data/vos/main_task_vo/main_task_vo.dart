import 'package:json_annotation/json_annotation.dart';


part 'main_task_vo.g.dart';

@JsonSerializable()
class MainTaskVO{

  @JsonKey(name: 'main_task_id')
  String? mainTaskID;

  @JsonKey(name: 'task')
  String? task;


  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'color')
  int? color;

  @JsonKey(name: 'order')
  int? order;

  @JsonKey(name: 'user_id')
  String? userID;

  MainTaskVO(
      this.mainTaskID, this.task, this.date, this.color, this.order, this.userID);

  factory MainTaskVO.fromJson(Map<String, dynamic> json) => _$MainTaskVOFromJson(json);

  Map<String, dynamic>toJson() => _$MainTaskVOToJson(this);
}