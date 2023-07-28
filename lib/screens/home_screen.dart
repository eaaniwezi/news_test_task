// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_test_task/bloc/news_bloc.dart';
import 'package:news_test_task/widgets/featured_widget.dart';
import 'package:news_test_task/widgets/latest_news_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 10),
          _header(),
          _textWidget("Featured"),
          SizedBox(height: 20),
          BlocConsumer<NewsBloc, NewsStates>(
            buildWhen: (oldState, newState) =>
                newState is NewsLoadingState ||
                newState is NewsLoadedState ||
                newState is NewsErrorState,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is NewsErrorState) {
                return Center(
                    child: Text(
                  "ERROR FETCHING FEATURED NEWS!!",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ));
              }
              if (state is NewsLoadedState) {
                var allNews = state.allNews;
                return FeaturedWidget(allNews: allNews);
              }
              return Text("");
            },
          ),
          SizedBox(height: 5),
          _textWidget("Latest news"),
          SizedBox(height: 20),
          BlocConsumer<NewsBloc, NewsStates>(
            buildWhen: (oldState, newState) =>
                newState is NewsLoadingState ||
                newState is NewsLoadedState ||
                newState is NewsErrorState,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is NewsErrorState) {
                return Center(
                    child: Text(
                  "ERROR FETCHING FEATURED NEWS!!",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ));
              }
              if (state is NewsLoadedState) {
                var allNews = state.allNews;
                var readNews = state.readNews;
                return ListView.builder(
                    itemCount: allNews.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var newsArticleModel = allNews[index];
                      return LastestNewsWidget(
                        newsArticleModel: newsArticleModel,
                        allNews: allNews,
                        isRead: readNews.contains(newsArticleModel),
                      );
                    });
              }
              return Text("");
            },
          )
        ],
      ),
    );
  }

  _textWidget(title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Text(
        title,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w300,
          fontSize: 20,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      ),
    );
  }

  _header() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset("images/back.png"),
        ),
        Spacer(),
        Center(
          child: Text(
            "Notifications",
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 20),
        BlocBuilder<NewsBloc, NewsStates>(
          buildWhen: (oldState, newState) =>
              newState is NewsLoadingState ||
              newState is NewsLoadedState ||
              newState is NewsErrorState,
          builder: (context, state) {
            if (state is NewsLoadedState) {
              var allNews = state.allNews;
              var allReadNews = state.readNews;

              return Center(
                child: InkWell(
                  onTap: () {
                    for (var news in allNews) {
                      allReadNews == allReadNews
                          ? context
                              .read<NewsBloc>()
                              .add(UnReadArticleEvent(newsModel: news))
                          : context
                              .read<NewsBloc>()
                              .add(ReadArticleEvent(newsModel: news));
                    }
                  },
                  child: Text(
                    allReadNews == allReadNews
                        ? "UnMark all news"
                        : "Mark all read",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }
            return Text("");
          },
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
