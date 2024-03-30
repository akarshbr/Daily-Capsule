import 'package:daily_report/presentation/category_screen/controller/category_screen_controller.dart';
import 'package:daily_report/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:daily_report/presentation/search_screen/controller/search_screen_controller.dart';
import 'package:daily_report/presentation/home_screen/controller/theme_controller.dart';
import 'package:daily_report/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';

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
