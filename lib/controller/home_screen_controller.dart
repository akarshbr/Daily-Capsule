import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/news_model.dart';

class HomeScreenController extends ChangeNotifier {
  late NewsModel newsModel;
  bool isLoading = false;
  int? code;

  void fetchData() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=7b0678fc8ecd4569a3521549029a0c3e");
    final response = await http.get(url);
    code=response.statusCode;
    log("${response.statusCode}");
    Map<String, dynamic> decodedData = {};
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
    } else {
      log("failed");
    }
    newsModel = NewsModel.fromJson(decodedData);
    isLoading = false;
    notifyListeners();
  }
}
