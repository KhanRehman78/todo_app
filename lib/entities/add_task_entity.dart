import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add_task_entity.g.dart';
@JsonSerializable()
class AddTaskEntity {
  String? taskName;
  String? image;
  String? userId;
  String? taskId;
  bool isCompleted;
  DateTime?dateTime;

  AddTaskEntity(
      {this.taskName,
        this.dateTime,
        this.image,
        this.userId,
        this.taskId,
        this.isCompleted = false});
  factory AddTaskEntity.fromJson(Map<String, dynamic> json) =>
      _$AddTaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskEntityToJson(this);

  static CollectionReference<AddTaskEntity> collection() {
    return FirebaseFirestore.instance.collection('taskDetails').withConverter(
      fromFirestore: (snapshot, options) =>
          AddTaskEntity.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static DocumentReference<AddTaskEntity> doc({required String taskId}) {
    return FirebaseFirestore.instance.doc('taskDetails/$taskId').withConverter(
      fromFirestore: (snapshot, options) {
        var glassEntities = AddTaskEntity.fromJson(snapshot.data()!);
        return glassEntities;
      },
      toFirestore: (value, options) => value.toJson(),
    );
  }
}
