// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchDetailModel _$LaunchDetailModelFromJson(Map<String, dynamic> json) =>
    LaunchDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      details: json['details'] as String?,
      date: DateTime.parse(json['date_utc'] as String),
      rocket: json['rocket'] as String,
    );

Map<String, dynamic> _$LaunchDetailModelToJson(LaunchDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'details': instance.details,
      'date_utc': instance.date.toIso8601String(),
      'rocket': instance.rocket,
    };
