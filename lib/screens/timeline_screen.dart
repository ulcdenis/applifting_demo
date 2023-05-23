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
                      return Theme(
                        data: ThemeData().copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          iconColor: Colors.black,
                          collapsedIconColor: Colors.black,
                          title: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${timeline[index].date.day}.${timeline[index].date.month}.${timeline[index].date.year}: ',
                                  style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                                ),
                                Expanded(
                                  child: Text(
                                    timeline[index].title,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(child: Text(timeline[index].details)),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {}, //TODO: do something
                              child: const Text('Detail'),
                            )
                          ],
                        ),
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
