// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_test_task/bloc/news_bloc.dart';
import 'package:news_test_task/widgets/featured_widget.dart';
import 'package:news_test_task/widgets/latest_news_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  double _previousScrollOffset = 0.0;
  bool _isScrollingUp = false;
  bool _isScrollingDown = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    _header(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              //!
              Expanded(
                child: ListView(
                  controller: _controller,
                  children: [
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
                          var readNews = state.readNews;
                          return _isScrollingDown
                              ? LastestNewsWidget(isRead: readNews.contains(allNews[0]), newsArticleModel: allNews[0], allNews: allNews)
                              : FeaturedWidget(allNews: allNews);
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
                          return _latestNewsBuilder(allNews, readNews);
                        }
                        return Text("");
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _latestNewsBuilder(allNews, readNews) {
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
          icon: Image.asset(
            "images/back.png",
            height: 24,
            width: 24,
          ),
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
                    if (allReadNews.length != allNews.length) {
                      for (var news in allNews) {
                        context
                            .read<NewsBloc>()
                            .add(ReadArticleEvent(newsModel: news));
                      }
                    } else {
                      for (var news in allNews) {
                        context
                            .read<NewsBloc>()
                            .add(UnReadArticleEvent(newsModel: news));
                      }
                    }
                  },
                  child: Text(
                    allReadNews.length == allNews.length
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

  void _handleScroll() {
    if (!_controller.hasClients) return;
    final currentScrollOffset = _controller.offset;
    if (currentScrollOffset > _previousScrollOffset) {
      setState(() {
        _isScrollingUp = false;
        _isScrollingDown = true;
      });
    } else if (currentScrollOffset < _previousScrollOffset) {
      setState(() {
        _isScrollingUp = true;
        _isScrollingDown = false;
      });
    }
    _previousScrollOffset = currentScrollOffset;
  }
}
