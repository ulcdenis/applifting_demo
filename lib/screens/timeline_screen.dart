import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/timeline_model.dart';
import 'package:applifting_demo/services/timeline_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late Future<List<TimelineModel>> timelineFuture = getTimeline();

  Future<List<TimelineModel>> getTimeline() async {
    if (!Provider.of<TimelineProvider>(context, listen: false).loaded) {
      return await Provider.of<TimelineProvider>(context, listen: false).getTimeline();
    }
    return Provider.of<TimelineProvider>(context, listen: false).timeline;
  }

  @override
  void initState() {
    getTimeline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch Detail'),
      ),
      body: Column(
        children: [
          CustomFutureBuilder(
              future: timelineFuture,
              builder: (timeline) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: timeline.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                left: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              )),
                              child: Theme(
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
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: -9,
                              child: Icon(
                                Icons.circle,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
