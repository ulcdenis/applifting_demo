import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'timeline_model.g.dart';

@JsonSerializable()
class TimelineModel {
  final String id;
  @JsonKey(name: 'event_date_utc')
  final DateTime date;
  final String title;
  final String details;

  TimelineModel({
    required this.id,
    required this.date,
    required this.title,
    required this.details,
  });

  factory TimelineModel.fromJson(Map<String, dynamic> json) => _$TimelineModelFromJson(json);
}
