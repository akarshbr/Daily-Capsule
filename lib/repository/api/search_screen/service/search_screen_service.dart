import 'dart:developer';

import 'package:daily_report/config/app_config.dart';
import 'package:daily_report/repository/helper/api_helper.dart';

class SearchScreenService {
  static Future<dynamic> searchData(keyWord) async {
    try {
      var decodedData = await ApiHelper.getData(
          endPoint: "everything?q=$keyWord&apiKey=${AppConfig.apiKey}");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
