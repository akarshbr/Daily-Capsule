import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:daily_report/model/news_model.dart';
import 'package:flutter/material.dart';

class SearchScreenController extends ChangeNotifier {
  NewsModel? newsModel;
  bool isLoading = true;
  int? code;

  Future<void> searchData({required String searchText}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchText&apiKey=7b0678fc8ecd4569a3521549029a0c3e");
    try {
      final response = await http.get(url, headers: {"Content-Type": "application/json"});
      code=response.statusCode;
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        newsModel = NewsModel.fromJson(decodedData);
      } else {
        log("Api failed");
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
