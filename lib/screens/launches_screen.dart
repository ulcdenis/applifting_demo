import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/launch_model.dart';
import 'package:applifting_demo/screens/filter_screen.dart';
import 'package:applifting_demo/screens/launch_detail_screen.dart';
import 'package:applifting_demo/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchesScreen extends StatefulWidget {
  const LaunchesScreen({super.key});

  @override
  State<LaunchesScreen> createState() => _LaunchesScreenState();
}

class _LaunchesScreenState extends State<LaunchesScreen> {
  SharedPreferences? prefs;

  bool searching = false;
  List<int> yearsFilter = [];

  late Future<List<LaunchModel>> launchesFuture = getLaunches();
  late Future<List<LaunchModel>> searchFuture;
  TextEditingController searchController = TextEditingController();

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

  void onSearch() {
    searchFuture = search();
    setState(() {
      searching = true;
    });
  }

  Future<List<LaunchModel>> search() async {
    List<LaunchModel> tempLaunches = await launchesFuture;
    List<LaunchModel> search = tempLaunches
        .where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
    if (yearsFilter.isNotEmpty) {
      search.removeWhere((element) => !yearsFilter.contains(element.date.year));
    }
    return search;
  }

  void onFilter() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FilterScreen(),
      ),
    );
    await setFilters();
  }

  Future<void> setFilters() async {
    yearsFilter = [];
    prefs ??= await SharedPreferences.getInstance();
    final List<String>? items = prefs!.getStringList('yearFilter');
    if (items != null) {
      for (var element in items) {
        yearsFilter.add(int.parse(element));
      }
    }
    onSearch();
  }

  @override
  void initState() {
    setFilters();
    getLaunches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launches'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () => onFilter(),
                icon: const Icon(Icons.filter_alt),
              ),
              if (yearsFilter.isNotEmpty)
                const Positioned(
                  top: 5,
                  right: 7,
                  child: Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 16,
                  ),
                )
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Search',
                iconColor: Colors.white,
                hintStyle: TextStyle(color: Colors.white),
                icon: Icon(Icons.search),
              ),
              cursorColor: Colors.white,
              controller: searchController,
              onChanged: (data) => onSearch(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          CustomFutureBuilder(
              future: searching ? searchFuture : launchesFuture,
              builder: (launches) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: launches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: GestureDetector(
                          onTap: () => onLaunchDetail(launches[index].id),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(launches[index].name)),
                              Text(
                                '${launches[index].date.day}.${launches[index].date.month}.${launches[index].date.year}',
                                style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
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
