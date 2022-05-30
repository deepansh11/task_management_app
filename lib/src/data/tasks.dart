import 'package:json_annotation/json_annotation.dart';

part 'tasks.g.dart';

@JsonSerializable()
class TaskResponse {
  final List<TaskData?>? data;

  TaskResponse(this.data);

  factory TaskResponse.fromJson(List<dynamic> json) {
    List<TaskData> taskData = <TaskData>[];
    taskData = json.map((e) => TaskData.fromJson(e)).toList();

    return TaskResponse(taskData);
  }
}

@JsonSerializable()
class TaskData {
  @JsonKey(name: '_id')
  final int? taskId;
  final String? taskName;
  final String? startLocation;
  final String? destination;
  final bool? wheelChair;
  final String? scheduleDate;
  final TaskStatus? taskStatus;
  final String? priority;
  final String? turnAroundTime;
  final String? acceptTime;
  final String? declineTime;
  final String? wheelChairType;
  final String? specialInstructions;

  TaskData(
    this.taskName,
    this.startLocation,
    this.destination,
    this.wheelChair,
    this.scheduleDate,
    this.taskId,
    this.taskStatus,
    this.priority,
    this.turnAroundTime,
    this.acceptTime,
    this.declineTime,
    this.wheelChairType,
    this.specialInstructions,
  );

  factory TaskData.fromJson(Map<String, dynamic> json) =>
      _$TaskDataFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDataToJson(this);
}

@JsonSerializable()
class TaskStatus {
  final int? taskId;
  final String? taskStatus;
  final String? assignedTo;

  TaskStatus(
    this.taskId,
    this.taskStatus,
    this.assignedTo,
  );

  factory TaskStatus.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusFromJson(json);
  Map<String, dynamic> toJson() => _$TaskStatusToJson(this);
}
