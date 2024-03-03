import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/news_model.dart';
import '../utils/api_service.dart';

class HomeScreenController extends ChangeNotifier {
  late NewsModel newsModel=NewsModel();
  bool isLoading = false;
  int? code;

  void fetchData() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "${APIService.header}top-headlines?country=in&apiKey=${APIService.apiKey}");
    final response = await http.get(url);
    code = response.statusCode;
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
