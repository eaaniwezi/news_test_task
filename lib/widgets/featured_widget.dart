// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import '../bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_test_task/models/news_model.dart';
import 'package:news_test_task/screens/news_details_screen.dart';
import 'package:news_test_task/widgets/carousel_img_container.dart';

class FeaturedWidget extends StatelessWidget {
  final List<NewsArticleModel> allNews;
  const FeaturedWidget({
    Key? key,
    required this.allNews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 1.0,
          ),
          items: allNews.map((NewsArticleModel newsArticleModel) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    context
                        .read<NewsBloc>()
                        .add(ReadArticleEvent(newsModel: newsArticleModel));
                    Get.to(() => NewsDetailsScreen(
                          newsArticleModel: newsArticleModel,
                          allNewsArticleModels: allNews,
                        ));
                  },
                  child:
                      CarouselImgContainer(newsArticleModel: newsArticleModel),
                );
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
