import 'package:daily_report/controller/search_screen_controller.dart';
import 'package:daily_report/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../controller/theme_controller.dart';
import 'custom_widget/news_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Provider.of<ThemeController>(context);
    SearchScreenController searchController = Provider.of<SearchScreenController>(context);

    return Scaffold(
      backgroundColor: themeController.darkTheme ? darkThemeBGColor : lightThemeBGColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: searchBarPadding,
              child: SearchBar(
                onSubmitted: (controller) {
                  searchController.searchData(searchText: controller.toLowerCase());
                },
                backgroundColor: const MaterialStatePropertyAll<Color>(searchBarBGColor),
                hintText: "Search",
                hintStyle:
                    const MaterialStatePropertyAll<TextStyle>(TextStyle(color: searchBarTextColor)),
                shape: MaterialStateProperty.all( RoundedRectangleBorder(borderRadius: borderRadius)),
              ),
            ),
            Expanded(
              child: Consumer<SearchScreenController>(builder: (context, searchController2, _) {
                return searchController2.isLoading == true
                    ? Center(
                        child: LottieBuilder(lottie: AssetLottie("assets/animation/capsule2.json")))
                    : searchController2.code == 429
                        ? const Center(child: Text("API limit exceeded"))
                        : ListView.separated(
                            itemCount: searchController2.newsModel?.articles?.length ?? 0,
                            itemBuilder: (context, index) {
                              return NewsCard(
                                title: searchController2.newsModel?.articles?[index].title
                                        .toString() ??
                                    "",
                                author: searchController2.newsModel?.articles?[index].author
                                        .toString() ??
                                    "",
                                description: searchController2
                                        .newsModel?.articles?[index].description
                                        .toString() ??
                                    "",
                                dateTime: searchController2.newsModel?.articles?[index].publishedAt,
                                imageURL: searchController2.newsModel?.articles?[index].urlToImage
                                        .toString() ??
                                    "",
                                source: searchController2.newsModel?.articles?[index].source
                                        .toString() ??
                                    "",
                                content: searchController2.newsModel?.articles?[index].content
                                        .toString() ??
                                    "",
                                url: searchController2.newsModel?.articles?[index].url.toString() ??
                                    "",
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                height: bottomNavScreensNewsCardSeparatorHeight,
                                width: MediaQuery.of(context).size.width,
                                color: themeController.darkTheme
                                    ? darkThemeNewsCardSeparatorColor
                                    : lightThemeNewsCardSeparatorColor,
                              );
                            },
                          );
              }),
            )
          ],
        ),
      ),
    );
  }
}
