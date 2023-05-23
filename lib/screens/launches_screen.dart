import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/launch_model.dart';
import 'package:applifting_demo/screens/launch_detail_screen.dart';
import 'package:applifting_demo/services/api_service.dart';
import 'package:flutter/material.dart';

class LaunchesScreen extends StatefulWidget {
  const LaunchesScreen({super.key});

  @override
  State<LaunchesScreen> createState() => _LaunchesScreenState();
}

class _LaunchesScreenState extends State<LaunchesScreen> {
  late Future<List<LaunchModel>> launchesFuture = getLaunches();

  Future<List<LaunchModel>> getLaunches() async {
    return await ApiService().getLaunches();
  }

  void onLaunchDetail(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LaunchDetailScreen(launchId: id),
      ),
    );
  }

  @override
  void initState() {
    getLaunches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launches'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: TextField(),
        ),
      ),
      body: Column(
        children: [
          CustomFutureBuilder(
              future: launchesFuture,
              builder: (launches) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: launches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: GestureDetector(
                          onTap: () => onLaunchDetail(launches[index].id),
                          child: Text(launches[index].name),
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
