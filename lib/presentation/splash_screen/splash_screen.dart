import 'dart:async';

import 'package:daily_report/presentation/home_screen/controller/theme_controller.dart';
import 'package:daily_report/core/constants/constants.dart';
import 'package:daily_report/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNavigationScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder(lottie: AssetLottie("assets/animation/capsule2.json")),
          Text("Daily Capsule",
              style: TextStyle(
                  fontSize: splashFontSize,
                  fontWeight: splashFontWeight,
                  color: Provider.of<ThemeController>(context).darkTheme
                      ? darkBackgroundTextColor
                      : lightBackgroundTextColor)),
        ],
      )),
    );
  }
}
