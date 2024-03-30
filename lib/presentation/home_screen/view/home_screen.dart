import 'package:daily_report/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:daily_report/presentation/home_screen/controller/theme_controller.dart';
import 'package:daily_report/core/constants/constants.dart';
import 'package:daily_report/widgets/news_card.dart';
import 'package:daily_report/presentation/search_screen/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void fetchData() {
    Provider.of<HomeScreenController>(context, listen: false).fetchData(context);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeController>(context).darkTheme
            ? darkThemeBGColor
            : lightThemeBGColor,
        elevation: appBarElevation,
        title: const Text("Daily Capsule"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Provider.of<ThemeController>(context, listen: false)
                    .switchTheme();
              },
              icon: Provider.of<ThemeController>(context).darkTheme
                  ? const Icon(Icons.sunny)
                  : const Icon(Icons.nights_stay))
        ],
      ),
      backgroundColor: Provider.of<ThemeController>(context).darkTheme
          ? darkThemeBGColor
          : lightThemeBGColor,
      body: Consumer<HomeScreenController>(
          builder: (context, homeScreenController, _) {
        // Provider.of<HomeScreenController>(context,listen: false).fetchData();
        return homeScreenController.isLoading == true
            ? Center(
                child: LottieBuilder(
                    lottie: AssetLottie("assets/animation/capsule2.json")))
            : homeScreenController.code == 429
                ? const Center(child: Text("API limit exceeded"))
                : ListView.separated(
                    itemCount:
                        homeScreenController.newsModel.articles?.length ?? 0,
                    itemBuilder: (context, index) {
                      return NewsCard(
                        //fetchData: ()=>Provider.of<HomeScreenController>(context,listen: false).fetchData(),
                        title: homeScreenController
                                .newsModel.articles?[index].title
                                .toString() ??
                            "",
                        author: homeScreenController
                                .newsModel.articles?[index].author
                                .toString() ??
                            "_",
                        description: homeScreenController
                                .newsModel.articles?[index].description
                                .toString() ??
                            "",
                        dateTime: homeScreenController
                            .newsModel.articles?[index].publishedAt,
                        imageURL: homeScreenController
                                .newsModel.articles?[index].urlToImage
                                .toString() ??
                            "",
                        source: homeScreenController
                                .newsModel.articles?[index].source?.name
                                .toString() ??
                            "",
                        content: homeScreenController
                                .newsModel.articles?[index].content
                                .toString() ??
                            "",
                        url: homeScreenController.newsModel.articles?[index].url
                                .toString() ??
                            "",
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: bottomNavScreensNewsCardSeparatorHeight,
                        width: MediaQuery.of(context).size.width,
                        color: Provider.of<ThemeController>(context).darkTheme
                            ? darkThemeNewsCardSeparatorColor
                            : lightThemeNewsCardSeparatorColor,
                      );
                    },
                  );
      }),
    );
  }
}
