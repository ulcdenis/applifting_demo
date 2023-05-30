import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'rocket_model.g.dart';

@JsonSerializable()
class RocketModel {
  final String id;
  final String name;
  final String? image;
  @JsonKey(name: 'home_port')
  final String? homePort;

  RocketModel({
    required this.id,
    required this.name,
    this.image,
    this.homePort,
  });

  factory RocketModel.fromJson(Map<String, dynamic> json) => _$RocketModelFromJson(json);
}
