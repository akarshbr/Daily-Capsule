import 'dart:developer';

import 'package:daily_report/config/app_config.dart';
import 'package:daily_report/repository/helper/api_helper.dart';

class CategoryScreenService {
  static Future<dynamic> fetchData(category) async {
    try {
      var decodedData = await ApiHelper.getData(
          endPoint:
              "top-headlines?country=in&category=$category&apiKey=${AppConfig.apiKey}");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
