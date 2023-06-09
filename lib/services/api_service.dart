import 'dart:convert';

import 'package:applifting_demo/models/launch_detail_model.dart';
import 'package:applifting_demo/models/launch_model.dart';
import 'package:applifting_demo/models/rocket_model.dart';
import 'package:applifting_demo/models/timeline_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future getLaunchesJson() async {
    Uri url = Uri.parse("https://api.spacexdata.com/v5/launches/");
    return http.get(url);
  }

  Future getLaunchDetailJson(String id) async {
    Uri url = Uri.parse("https://api.spacexdata.com/v5/launches/$id");
    return http.get(url);
  }

  Future getTimelineJson() async {
    Uri url = Uri.parse("https://api.spacexdata.com/v4/history/");
    return http.get(url);
  }

  Future getRocketJson(String id) async {
    Uri url = Uri.parse("https://api.spacexdata.com/v4/rockets/$id");
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

  Future<LaunchDetailModel> getLaunchDetail(String id) async {
    dynamic response = await getLaunchDetailJson(id);
    dynamic item = jsonDecode(response.body);
    LaunchDetailModel launch = LaunchDetailModel.fromJson(item);
    return launch;
  }

  Future<List<TimelineModel>> getTimeline() async {
    List<TimelineModel> timeline = [];
    dynamic response = await getTimelineJson();
    dynamic items = jsonDecode(response.body);
    if (items == null) return [];
    for (var eventJson in items) {
      TimelineModel event = TimelineModel.fromJson(eventJson);
      timeline.add(event);
    }
    return timeline;
  }

  Future<RocketModel> getRocket(String id) async {
    dynamic response = await getRocketJson(id);
    dynamic item = jsonDecode(response.body);
    RocketModel rocket = RocketModel.fromJson(item);
    return rocket;
  }
}
