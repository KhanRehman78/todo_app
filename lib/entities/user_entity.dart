import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_entity.g.dart';
@JsonSerializable()
class UserEntity{
  String? name;
  String? email;
  String? uid;
  String? profileImage;

  UserEntity({this.name, this.email, this.uid,this.profileImage});

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  static CollectionReference<UserEntity> collection() {
    return FirebaseFirestore.instance.collection('userDetails').withConverter(
      fromFirestore: (snapshot, options) =>
          UserEntity.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static DocumentReference<UserEntity> doc({required String userId}) {
    return FirebaseFirestore.instance.doc('userDetails/$userId').withConverter(
      fromFirestore: (snapshot, options) {
        var glassEntities = UserEntity.fromJson(snapshot.data()!);
        return glassEntities;
      },
      toFirestore: (value, options) => value.toJson(),
    );
  }
}