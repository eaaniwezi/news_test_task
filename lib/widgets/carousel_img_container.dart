import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news_test_task/models/news_model.dart';

class CarouselImgContainer extends StatelessWidget {
  final NewsArticleModel newsArticleModel;
  final  double? height;
  const CarouselImgContainer({
    Key? key,
    required this.newsArticleModel,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: newsArticleModel.urlToImage == null
          ? BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(12),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  newsArticleModel.urlToImage.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            newsArticleModel.title == null
                ? "NO TITLE"
                : newsArticleModel.title.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w300,
              fontSize: 28,
              fontStyle: FontStyle.italic,
              color: newsArticleModel.urlToImage == null
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
