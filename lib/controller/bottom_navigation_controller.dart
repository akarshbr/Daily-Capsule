import 'package:daily_report/controller/category_screen_controller.dart';
import 'package:daily_report/view/category_screen.dart';
import 'package:daily_report/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/search_screen.dart';

class BottomNavigationController extends ChangeNotifier {
  int selectedIndex = 0;

  void onItemTap(index,context) {
    selectedIndex = index;
    if(index==1){
      Provider.of<CategoryScreenController>(context,listen: false).fetchData();
    }
    notifyListeners();
  }

  List screens = [const HomeScreen(), const CategoryScreen(), const SearchScreen()];
}
