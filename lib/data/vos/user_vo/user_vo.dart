

import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO{
  @JsonKey(name: 'user_id')
  String userID;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'profile')
  String? profile;



  UserVO(this.userID, this.firstName, this.lastName, this.email, this.password,
      this.profile);

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic>toJson() => _$UserVOToJson(this);
}