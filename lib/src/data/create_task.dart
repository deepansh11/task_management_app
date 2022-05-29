import 'package:json_annotation/json_annotation.dart';

part 'create_task.g.dart';

@JsonSerializable()
class CreateTaskData {
  final String? taskName;
  final String? startLocation;
  final String? destination;
  final bool? wheelChair;
  final String? scheduleDate;
  final String? priority;

  CreateTaskData(
    this.taskName,
    this.startLocation,
    this.destination,
    this.wheelChair,
    this.scheduleDate,
    this.priority,
  );

  factory CreateTaskData.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskDataFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTaskDataToJson(this);
}

@JsonSerializable()
class CreateTaskForFirebase {
  final String? id;
  final Map<String, dynamic>? taskData;

  CreateTaskForFirebase(this.id, this.taskData);

  factory CreateTaskForFirebase.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskForFirebaseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTaskForFirebaseToJson(this);
}
