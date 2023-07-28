import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_test_task/bloc/news_bloc.dart';
import 'package:news_test_task/models/news_model.dart';
import 'package:news_test_task/screens/news_details_screen.dart';

class LastestNewsWidget extends StatelessWidget {
  final bool isRead;
  final NewsArticleModel newsArticleModel;
  final List<NewsArticleModel> allNews;
  const LastestNewsWidget({
    Key? key,
    required this.isRead,
    required this.newsArticleModel,
    required this.allNews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: InkWell(
        onTap: () {
          isRead
              ? print("")
              : context
                  .read<NewsBloc>()
                  .add(ReadArticleEvent(newsModel: newsArticleModel));
          Get.to(() => NewsDetailsScreen(
                newsArticleModel: newsArticleModel,
                allNewsArticleModels: allNews,
              ));
        },
        child: Material(
          elevation: 5,
          color: isRead ? null : Colors.white,
          borderRadius: BorderRadius.circular(9),
          child: Container(
            height: 103,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: isRead ? null : Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 60,
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
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        newsArticleModel.title == null
                            ? "NO TITLE"
                            : newsArticleModel.title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "1 day ago",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
