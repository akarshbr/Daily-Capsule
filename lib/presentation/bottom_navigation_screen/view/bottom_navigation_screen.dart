import 'package:daily_report/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home_screen/controller/theme_controller.dart';
import '../../../core/constants/constants.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigationController controller = Provider.of<BottomNavigationController>(context);
    return Scaffold(
      body: controller.screens[Provider.of<BottomNavigationController>(context).selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          backgroundColor: Provider.of<ThemeController>(context).darkTheme ? darkThemeBGColor : lightThemeBGColor,
          selectedItemColor: bottomNavIconColor,
          elevation: bottomNavigationBarElevation,
          onTap: (index) {
            Provider.of<BottomNavigationController>(context, listen: false).onItemTap(index,context);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          ]),
    );
  }
}
