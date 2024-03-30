import 'dart:developer';

import 'package:daily_report/config/app_config.dart';
import 'package:daily_report/repository/helper/api_helper.dart';

class HomeScreenService {
  static Future<dynamic> fetchData() async {
    log("HomeScreenService -> fetchData()");
    try {
      var decodedData = await ApiHelper.getData(
          endPoint: "top-headlines?country=in&apiKey=${AppConfig.apiKey}");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
