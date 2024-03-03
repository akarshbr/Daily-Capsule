import 'package:daily_report/controller/category_screen_controller.dart';
import 'package:daily_report/view/custom_widget/news_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../controller/theme_controller.dart';
import '../utils/constants.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Provider.of<ThemeController>(context);
    return Consumer<CategoryScreenController>(builder: (context, categoryController, _) {
      return DefaultTabController(
        length: categoryController.categoryList.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: themeController.darkTheme ? darkThemeBGColor : lightThemeBGColor,
            elevation: appBarElevation,
            title: const Text("Daily Capsule"),
            bottom: TabBar(
              isScrollable: true,
              tabs: List.generate(categoryController.categoryList.length,
                  (index) => Tab(text: categoryController.categoryList[index])),
              onTap: (value) {
                categoryController.onTap(index: value);
              },
            ),
          ),
          backgroundColor: themeController.darkTheme ? darkThemeBGColor : lightThemeBGColor,
          body: Consumer<CategoryScreenController>(builder: (context, categoryController, _) {
            return categoryController.isLoading == true
                ? Center(child: LottieBuilder(lottie: AssetLottie("assets/animation/capsule2.json")))
                : categoryController.code == 429
                    ? const Center(child: Text("API limit exceeded"))
                    : ListView.separated(
                        itemCount: categoryController.newsModel.articles?.length ?? 0,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            //fetchData: () =>Provider.of<CategoryScreenController>(context,listen: false).fetchData(),
                            title:
                                categoryController.newsModel.articles?[index].title.toString() ?? "",
                            author:
                                categoryController.newsModel.articles?[index].author.toString() ?? "",
                            description: categoryController.newsModel.articles?[index].description
                                    .toString() ??
                                "",
                            dateTime: categoryController.newsModel.articles?[index].publishedAt,
                            imageURL:
                                categoryController.newsModel.articles?[index].urlToImage.toString() ??
                                    "",
                            source:
                                categoryController.newsModel.articles?[index].source.toString() ?? "",
                            content:
                                categoryController.newsModel.articles?[index].content.toString() ??
                                    "",
                            url: categoryController.newsModel.articles?[index].content.toString() ??
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
        ),
      );
    });
  }
}
