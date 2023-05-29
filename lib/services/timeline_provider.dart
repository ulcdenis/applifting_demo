import 'package:applifting_demo/models/timeline_model.dart';
import 'package:applifting_demo/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class TimelineProvider extends ChangeNotifier {
  bool loaded = false;
  List<TimelineModel> timeline = [];

  TimelineProvider() {
    if (!loaded) {
      getTimeline();
    }
  }

  Future<List<TimelineModel>> getTimeline() async {
    timeline = await ApiService().getTimeline();
    loaded = true;
    notifyListeners();
    return timeline;
  }
}
