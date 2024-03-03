import 'package:daily_report/controller/category_screen_controller.dart';
import 'package:daily_report/controller/home_screen_controller.dart';
import 'package:daily_report/controller/search_screen_controller.dart';
import 'package:daily_report/controller/theme_controller.dart';
import 'package:daily_report/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/bottom_navigation_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeScreenController()),
    ChangeNotifierProvider(create: (context) => SearchScreenController()),
    ChangeNotifierProvider(create: (context) => BottomNavigationController()),
    ChangeNotifierProvider(create: (context) => CategoryScreenController()),
    ChangeNotifierProvider(create: (context) => ThemeController())
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeController>(context).darkTheme
          ? ThemeData.dark()
          : ThemeData.light(),
      //theme: ThemeData.light(),
    );
  }
}
