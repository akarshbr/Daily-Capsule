import 'dart:developer';
import 'package:daily_report/core/utils/app_utils.dart';
import 'package:daily_report/repository/api/search_screen/service/search_screen_service.dart';
import 'package:daily_report/repository/api/common/model/news_model.dart';
import 'package:flutter/material.dart';

class SearchScreenController extends ChangeNotifier {
  NewsModel? newsModel;
  bool isLoading = true;
  int? code;

  Future<void> searchData(context, {required String searchText}) async {
    isLoading = true;
    notifyListeners();
    log("SearchScreenController -> searchData()");
    SearchScreenService.searchData(searchText).then((value) {
      if (value["status"] == "ok") {
        newsModel = NewsModel.fromJson(value);
        isLoading = false;
      } else if (value == 429) {
        code = 429;
      } else {
        AppUtils.oneTimeSnackBar(value["message"], context: context);
      }
      notifyListeners();
    });
  }
}
