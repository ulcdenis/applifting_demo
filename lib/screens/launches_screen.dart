import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/launch_model.dart';
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

  @override
  void initState() {
    getLaunches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomFutureBuilder(
              future: launchesFuture,
              builder: (launches) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: launches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(launches[index].name);
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
