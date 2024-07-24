// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaskEntity _$AddTaskEntityFromJson(Map<String, dynamic> json) =>
    AddTaskEntity(
      taskName: json['taskName'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      image: json['image'] as String?,
      userId: json['userId'] as String?,
      taskId: json['taskId'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$AddTaskEntityToJson(AddTaskEntity instance) =>
    <String, dynamic>{
      'taskName': instance.taskName,
      'image': instance.image,
      'userId': instance.userId,
      'taskId': instance.taskId,
      'isCompleted': instance.isCompleted,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
