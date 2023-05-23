// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RocketModel _$ShipModelFromJson(Map<String, dynamic> json) => RocketModel(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      homePort: json['home_port'] as String?,
    );

Map<String, dynamic> _$ShipModelToJson(RocketModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'home_port': instance.homePort,
    };
