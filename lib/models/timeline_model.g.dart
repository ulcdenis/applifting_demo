// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineModel _$TimelineModelFromJson(Map<String, dynamic> json) =>
    TimelineModel(
      id: json['id'] as String,
      date: DateTime.parse(json['event_date_utc'] as String),
      title: json['title'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_date_utc': instance.date.toIso8601String(),
      'title': instance.title,
      'details': instance.details,
    };
