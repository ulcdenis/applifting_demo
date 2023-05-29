import 'package:applifting_demo/models/launch_model.dart';
import 'package:applifting_demo/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class LaunchesProvider extends ChangeNotifier {
  bool loaded = false;
  List<LaunchModel> launches = [];

  LaunchesProvider() {
    if (!loaded) {
      getLaunches();
    }
  }

  Future<List<LaunchModel>> getLaunches() async {
    launches = await ApiService().getLaunches();
    loaded = true;
    notifyListeners();
    return launches;
  }
}
