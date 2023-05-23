import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/launch_detail_model.dart';
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
  late Future<LaunchDetailModel> launchFuture = getLaunch();

  Future<LaunchDetailModel> getLaunch() async {
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
        title: const Text('Launch Detail'),
      ),
      body: CustomFutureBuilder(
          future: launchFuture,
          builder: (launch) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    launch.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '${launch.date.day}.${launch.date.month}.${launch.date.year}',
                    style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 16),
                  ),
                  const Divider(),
                  if (launch.details != null)
                    Text(
                      launch.details!,
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
