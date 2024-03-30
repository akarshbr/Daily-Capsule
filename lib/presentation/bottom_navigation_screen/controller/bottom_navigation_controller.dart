import 'package:daily_report/presentation/category_screen/view/category_screen.dart';
import 'package:daily_report/presentation/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';
import '../../search_screen/view/search_screen.dart';

class BottomNavigationController extends ChangeNotifier {
  int selectedIndex = 0;

  void onItemTap(index,context) {
    selectedIndex = index;
    notifyListeners();
  }

  List screens = [const HomeScreen(), const CategoryScreen(), const SearchScreen()];
}
