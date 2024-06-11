import 'dart:developer';

import 'package:daily_report/core/utils/app_utils.dart';
import 'package:daily_report/repository/api/category_screen/service/category_service.dart';
import 'package:daily_report/repository/api/common/model/news_model.dart';
import 'package:flutter/material.dart';

class CategoryScreenController extends ChangeNotifier {
  List<String> categoryList = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  String category = "business";
  int? code;
  late NewsModel newsModel = NewsModel();
  bool isLoading = false;

   fetchData(context) async {
    isLoading = true;
    notifyListeners();
    log("CategoryScreenController -> fetchData()");
    CategoryScreenService.fetchData(category).then((value) {
      if (value["status"] == "ok") {
        newsModel = NewsModel.fromJson(value);
        isLoading = false;
      } else if (value == 429) {
        code = 429;
      } else {
        AppUtils.oneTimeSnackBar("Error", context: context);
      }
      notifyListeners();
    });
  }

  void onTap(BuildContext context,{required int index,}) {
    category = categoryList[index].toLowerCase();
    fetchData(context);
    notifyListeners();
  }
}
