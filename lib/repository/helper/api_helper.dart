import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:daily_report/config/app_config.dart';

class ApiHelper {
  static getData(
      {required String endPoint, Map<String, dynamic>? header}) async {
    log("ApiHelper -> getData()");
    final url = Uri.parse(AppConfig.baseUrl + endPoint);
    log("final url -> $url");
    try {
      var response = await http.get(url);
      log("status code -> ${response.statusCode}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        //log(decodedData.toString());
        return decodedData;
      } else if (response.statusCode == 429) {
        return response.statusCode;
      } else {
        var decodedData = jsonDecode(response.body);
        log("Api failed");
        return decodedData;
      }
    } catch (e) {
      log("$e");
    }
  }
}
