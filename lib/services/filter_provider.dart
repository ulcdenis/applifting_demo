import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterProvider extends ChangeNotifier {
  SharedPreferences? prefs;

  bool initialized = false;

  List<int> yearFilter = [];
  bool yearSort = false;

  Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();
    final List<String>? items = prefs!.getStringList('yearFilter');
    if (items != null) {
      for (var element in items) {
        yearFilter.add(int.parse(element));
      }
    }

    bool? sort = prefs!.getBool('yearSort');
    yearSort = sort ?? false;

    initialized = true;
    notifyListeners();
  }

  setFilter(List<int> items) async {
    yearFilter = items;
    List<String> strList = items.map((i) => i.toString()).toList();
    await prefs!.remove('yearFilter');
    await prefs!.setStringList('yearFilter', strList);
  }

  setSort(bool item) async {
    yearSort = item;
    await prefs!.setBool('yearSort', item);
  }
}
