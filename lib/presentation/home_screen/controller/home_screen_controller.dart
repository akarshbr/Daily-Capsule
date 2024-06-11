import 'dart:developer';

import 'package:daily_report/core/utils/app_utils.dart';
import 'package:daily_report/repository/api/home_screen/service/home_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../repository/api/common/model/news_model.dart';

class HomeScreenController extends ChangeNotifier {
  late NewsModel newsModel = NewsModel();
  bool isLoading = false;
  int? code;

   fetchData(context) async {
    isLoading = true;
    notifyListeners();
    log("HomeScreenController -> fetchData()");
    HomeScreenService.fetchData().then((value) {
      if (value["status"] == "ok") {
        newsModel = NewsModel.fromJson(value);
        isLoading = false;
      } else if (value == 429) {
        code = 429;
      } else {
        AppUtils.oneTimeSnackBar("error", context: context);
      }
      notifyListeners();
    });
  }

  Future<void> launchURL(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception("could not launch");
    }
    notifyListeners();
  }

  void shareUrl({String url = ""}) {
    try {
      Share.share(url);
    } catch (error) {
      log("$error");
    }
  }
}
