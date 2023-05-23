import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final SharedPreferences prefs;
  List<int> years = [];
  List<int> selectedYears = [];
  bool sortDescending = false;

  void getYears() {
    int initialYear = 2006;
    int todayYear = DateTime.now().year;

    for (int index = 0; index < todayYear - initialYear + 1; index++) {
      years.add(initialYear + index);
    }
  }

  void setPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('yearFilter');
    if (items != null) {
      for (var element in items) {
        setState(() {
          selectedYears.add(int.parse(element));
        });
      }
    }

    final bool? sort = prefs.getBool('yearSort');
    if (sort != null) {
      setState(() {
        sortDescending = sort;
      });
    }
  }

  void changeSort() async {
    setState(() {
      sortDescending = !sortDescending;
    });
    await prefs.setBool('yearSort', sortDescending);
  }

  void saveFilter() async {
    List<String> strList = selectedYears.map((i) => i.toString()).toList();
    await prefs.remove('yearFilter');
    await prefs.setStringList('yearFilter', strList);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  void initState() {
    setPrefs();
    getYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Sort by:',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const Text(
                    'years',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () => changeSort(),
                      icon: RotatedBox(
                        quarterTurns: sortDescending ? 2 : 0,
                        child: const Icon(Icons.arrow_downward),
                      ))
                ],
              ),
            ),
            Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,
                title: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Launch years',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        selectedYears.length.toString(),
                        style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: years.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedYears.contains(years[index])) {
                                selectedYears.removeWhere((element) => element == years[index]);
                              } else {
                                selectedYears.add(years[index]);
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(years[index].toString()),
                              ),
                              Icon(
                                Icons.done,
                                color: selectedYears.contains(years[index]) ? Colors.black : Colors.transparent,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: Container()),
            TextButton(
              onPressed: () => saveFilter(),
              child: const Text('DONE'),
            )
          ],
        ),
      ),
    );
  }
}
