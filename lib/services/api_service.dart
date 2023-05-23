import 'dart:convert';

import 'package:applifting_demo/models/launch_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future getLaunchesJson() async {
    Uri url = Uri.parse("https://api.spacexdata.com/v5/launches/");
    return http.get(url);
  }

  Future<List<LaunchModel>> getLaunches() async {
    List<LaunchModel> launches = [];
    dynamic response = await getLaunchesJson();
    dynamic items = jsonDecode(response.body);
    if (items == null) return [];
    for (var launchJson in items) {
      LaunchModel launch = LaunchModel.fromJson(launchJson);
      launches.add(launch);
    }
    return launches;
  }
}
