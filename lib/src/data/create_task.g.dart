// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTaskData _$CreateTaskDataFromJson(Map<String, dynamic> json) =>
    CreateTaskData(
      json['taskName'] as String?,
      json['startLocation'] as String?,
      json['destination'] as String?,
      json['wheelChair'] as bool?,
      json['scheduleDate'] as String?,
      json['priority'] as String?,
    );

Map<String, dynamic> _$CreateTaskDataToJson(CreateTaskData instance) =>
    <String, dynamic>{
      'taskName': instance.taskName,
      'startLocation': instance.startLocation,
      'destination': instance.destination,
      'wheelChair': instance.wheelChair,
      'scheduleDate': instance.scheduleDate,
      'priority': instance.priority,
    };

CreateTaskForFirebase _$CreateTaskForFirebaseFromJson(
        Map<String, dynamic> json) =>
    CreateTaskForFirebase(
      json['id'] as String?,
      json['taskData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateTaskForFirebaseToJson(
        CreateTaskForFirebase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskData': instance.taskData,
    };
