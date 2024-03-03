import 'package:daily_report/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen(
      {super.key,
      required this.title,
      required this.author,
      required this.source,
      required this.description,
      required this.date,
      required this.imageURL,
      required this.content,
      required this.url});

  final String title;
  final String author;
  final String source;
  final String description;
  final DateTime? date;
  final String imageURL;
  final String content;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Capsule"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: newsCardDetailsContainerMargin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: newsCardDetailsTitleTextStyle),
              sizedBoxHeight,
              Text("✍️ $author", style: newsCardDetailsTextStyle),
              sizedBoxHeight,
              Row(
                children: [
                  Text(source, style: newsCardDetailsSourceTextStyle),
                  sizedBoxWidth,
                  Text(DateFormat("dd/MM/yyyy").format(date!).toString())
                ],
              ),
              sizedBoxHeight,
              Container(
                height: newsCardDetailsImageHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    image: DecorationImage(image: NetworkImage(imageURL), fit: BoxFit.cover)),
              ),
              sizedBoxHeight,
              Text(
                content,
                style: newsCardDetailsContentTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Provider.of<HomeScreenController>(context, listen: false).launchURL(url);
                      },
                      child: const Text("Go to source")),
                  IconButton(
                      onPressed: () {
                        String newsShare = "$title\n$url";
                        Provider.of<HomeScreenController>(context,listen: false).shareUrl(url: newsShare);
                      },
                      icon: const Icon(Icons.share))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
