// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_test_task/models/news_model.dart';
import 'package:news_test_task/widgets/carousel_img_container.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsArticleModel newsArticleModel;
  final List<NewsArticleModel> allNewsArticleModels;
  const NewsDetailsScreen({
    Key? key,
    required this.newsArticleModel,
    required this.allNewsArticleModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              _imageHolder(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(
                    "images/back.png",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          _description(),
          // ListView.builder(
          //     itemCount: allNewsArticleModels
          //         .where((currentModel) => currentModel != newsArticleModel)
          //         .length,
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       var otherNews = allNewsArticleModels
          //           .where((currentModel) => currentModel != newsArticleModel)
          //           .toList()[index];
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 8),
          //         child: InkWell(
          //           onTap: () {
          //             // context
          //             // .read<NewsBloc>()
          //             // .add(SaveArticleEvent(model: newsArticleModel));
          //             Get.to(() => NewsDetailsScreen(
          //                   newsArticleModel: newsArticleModel,
          //                   allNewsArticleModels: allNewsArticleModels,
          //                 ));
          //           },
          //           child: CarouselImgContainer(
          //             newsArticleModel: otherNews,
          //             height: 300,
          //           ),
          //         ),
          //       );
          //       // return Text("data");
          //     })
        ],
      ),
    );
  }

  _description() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        newsArticleModel.description.toString(),
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  _imageHolder(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: newsArticleModel.urlToImage == null
            ? BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
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
        ));
  }
}
