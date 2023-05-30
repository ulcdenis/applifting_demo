import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'launch_detail_model.g.dart';

@JsonSerializable()
class LaunchDetailModel {
  final String id;
  final String name;
  final String? details;
  @JsonKey(name: 'date_utc')
  final DateTime date;
  final String rocket;

  LaunchDetailModel({
    required this.id,
    required this.name,
    this.details,
    required this.date,
    required this.rocket,
  });

  factory LaunchDetailModel.fromJson(Map<String, dynamic> json) => _$LaunchDetailModelFromJson(json);
}
