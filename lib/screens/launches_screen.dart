import 'package:applifting_demo/components/custom_future_builder.dart';
import 'package:applifting_demo/models/launch_model.dart';
import 'package:applifting_demo/screens/filter_screen.dart';
import 'package:applifting_demo/screens/launch_detail_screen.dart';
import 'package:applifting_demo/services/filter_provider.dart';
import 'package:applifting_demo/services/launches_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaunchesScreen extends StatefulWidget {
  const LaunchesScreen({super.key});

  @override
  State<LaunchesScreen> createState() => _LaunchesScreenState();
}

class _LaunchesScreenState extends State<LaunchesScreen> {
  bool searching = false;
  List<int> yearsFilter = [];
  bool sortDescending = false;

  late Future<List<LaunchModel>> launchesFuture = getLaunches();
  late Future<List<LaunchModel>> searchFuture;
  TextEditingController searchController = TextEditingController();

  Future<List<LaunchModel>> getLaunches() async {
    if (!Provider.of<LaunchesProvider>(context, listen: false).loaded) {
      return await Provider.of<LaunchesProvider>(context, listen: false).getLaunches();
    }
    return Provider.of<LaunchesProvider>(context, listen: false).launches;
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

    if (sortDescending) {
      search.sort((a, b) => b.date.compareTo(a.date));
    } else {
      search.sort((a, b) => a.date.compareTo(b.date));
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
    if (!Provider.of<FilterProvider>(context, listen: false).initialized) {
      await Provider.of<FilterProvider>(context, listen: false).init();
    }
    setState(() {
      yearsFilter = Provider.of<FilterProvider>(context, listen: false).yearFilter;
      sortDescending = Provider.of<FilterProvider>(context, listen: false).yearSort;
    });
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
                Positioned(
                  top: 5,
                  right: 7,
                  child: GestureDetector(
                    onTap: () => onFilter(),
                    child: const Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 16,
                    ),
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
                if (launches.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'List is empty.',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
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
