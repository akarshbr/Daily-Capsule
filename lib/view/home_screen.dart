import 'package:daily_report/controller/home_screen_controller.dart';
import 'package:daily_report/controller/theme_controller.dart';
import 'package:daily_report/utils/constants.dart';
import 'package:daily_report/view/custom_widget/news_card.dart';
import 'package:daily_report/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    Provider.of<HomeScreenController>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    HomeScreenController provider = Provider.of<HomeScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeController>(context).darkTheme ? darkThemeBGColor : lightThemeBGColor,
        elevation: appBarElevation,
        title: const Text("Daily Capsule"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const SearchScreen()));
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Provider.of<ThemeController>(context, listen: false).switchTheme();
              },
              icon: Provider.of<ThemeController>(context).darkTheme
                  ? const Icon(Icons.sunny)
                  : const Icon(Icons.nights_stay))
        ],
      ),
      backgroundColor:
          Provider.of<ThemeController>(context).darkTheme ? darkThemeBGColor : lightThemeBGColor,
      body: Provider.of<HomeScreenController>(context).isLoading == true
          ? Center(child: LottieBuilder(lottie: AssetLottie("assets/animation/capsule2.json")))
          : Provider.of<HomeScreenController>(context).code == 429
              ? const Center(child: Text("API limit exceeded"))
              : ListView.separated(
                  itemCount: provider.newsModel.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      title: provider.newsModel.articles?[index].title.toString() ?? "",
                      author: provider.newsModel.articles?[index].author.toString() ?? "_",
                      description: provider.newsModel.articles?[index].description.toString() ?? "",
                      dateTime: provider.newsModel.articles?[index].publishedAt,
                      imageURL: provider.newsModel.articles?[index].urlToImage.toString() ?? "",
                      source: provider.newsModel.articles?[index].source?.name.toString() ?? "",
                      content: provider.newsModel.articles?[index].content.toString() ?? "",
                      url: provider.newsModel.articles?[index].url.toString() ?? "",
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
                ),
    );
  }
}
