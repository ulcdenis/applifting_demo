// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchModel _$LaunchModelFromJson(Map<String, dynamic> json) => LaunchModel(
      id: json['id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date_utc'] as String),
    );

Map<String, dynamic> _$LaunchModelToJson(LaunchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date_utc': instance.date.toIso8601String(),
    };
