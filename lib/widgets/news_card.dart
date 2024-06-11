import 'package:daily_report/widgets/news_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/constants/constants.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.title,
    required this.author,
    required this.description,
    required this.dateTime,
    required this.imageURL,
    required this.source,
    required this.content,
    required this.url,
  });

  final String title;
  final String author;
  final String description;
  final DateTime? dateTime;
  final String imageURL;
  final String source;
  final String content;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailsScreen(
                      title: title,
                      author: author,
                      source: source,
                      description: description,
                      imageURL: imageURL,
                      content: content,
                      url: url,
                      date: dateTime,
                    )));
      },
      child: Container(
        margin: newsCardContainerMarginEdgeInsets,
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: newsCardTextEdgeInset,
              child: Text(title, style: newsCardTitleTextStyle),
            ),
            Padding(
              padding: newsCardTextEdgeInset,
              child: Row(
                children: [
                  Text("✍️$author", style: newsCardAuthorTextStyle),
                  sizedBoxWidth,
                  Text(DateFormat("dd/MM/yyyy").format(dateTime!).toString())
                ],
              ),
            ),
            Container(
              height: newsCardImageHeight,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(imageURL), fit: BoxFit.cover),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 5),
            //   child: Text(description),
            // )
          ],
        ),
      ),
    );
  }
}
