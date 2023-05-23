import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/launch_model.dart';
import 'package:applifting_demo/services/api_service.dart';
import 'package:flutter/material.dart';

class LaunchDetailScreen extends StatefulWidget {
  final String launchId;
  const LaunchDetailScreen({
    required this.launchId,
    super.key,
  });

  @override
  State<LaunchDetailScreen> createState() => _LaunchDetailScreenState();
}

class _LaunchDetailScreenState extends State<LaunchDetailScreen> {
  late Future<LaunchModel> launchFuture = getLaunch();

  Future<LaunchModel> getLaunch() async {
    return await ApiService().getLaunchDetail(widget.launchId);
  }

  @override
  void initState() {
    getLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter demo'),
      ),
      body: CustomFutureBuilder(
          future: launchFuture,
          builder: (launch) {
            return Center(
              child: Text('LAUNCH DETAIL: ${launch.name}'),
            );
          }),
    );
  }
}
