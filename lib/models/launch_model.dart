import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'launch_model.g.dart';

@JsonSerializable()
class LaunchModel {
  final String id;
  final String name;
  @JsonKey(name: 'date_utc')
  final DateTime date;

  LaunchModel({required this.id, required this.name, required this.date});

  factory LaunchModel.fromJson(Map<String, dynamic> json) => _$LaunchModelFromJson(json);
}
