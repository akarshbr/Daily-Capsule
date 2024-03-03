import 'dart:convert';
import 'dart:developer';

import 'package:daily_report/model/news_model.dart';
import 'package:daily_report/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  void fetchData() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "${APIService.header}top-headlines?country=in&category=$category&apiKey=${APIService.apiKey}");
    final response = await http.get(url);
    code = response.statusCode;
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

  void onTap({required int index}) {
    category = categoryList[index].toLowerCase();
    fetchData();
    notifyListeners();
  }
}
