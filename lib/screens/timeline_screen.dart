import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/timeline_model.dart';
import 'package:applifting_demo/services/api_service.dart';
import 'package:flutter/material.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late Future<List<TimelineModel>> timelineFuture = getTimeline();

  Future<List<TimelineModel>> getTimeline() async {
    return await ApiService().getTimeline();
  }

  @override
  void initState() {
    getTimeline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomFutureBuilder(
              future: timelineFuture,
              builder: (timeline) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: timeline.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(timeline[index].title),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
