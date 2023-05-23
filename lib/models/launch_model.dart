import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'launch_model.g.dart';

@JsonSerializable(createToJson: true)
class LaunchModel {
  final String id;
  final String name;

  LaunchModel({
    required this.id,
    required this.name,
  });

  factory LaunchModel.fromJson(Map<String, dynamic> json) => _$LaunchModelFromJson(json);
}
