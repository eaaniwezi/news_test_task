// ignore_for_file: avoid_print

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test_task/models/news_model.dart';
import 'package:news_test_task/repositories/news_repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepo newsRepo;

  NewsBloc({
    required NewsStates initialState,
    required this.newsRepo,
  }) : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        late List<NewsArticleModel> _allNewsArticleList;
        late List<NewsArticleModel> _allSavedArticleList;

        yield NewsLoadingState();

        _allNewsArticleList = await newsRepo.getAllNews();
        _allSavedArticleList = await newsRepo.getReadNews();

        yield NewsLoadedState(
          allNews: _allNewsArticleList,
          readNews: _allSavedArticleList,
        );
      } catch (e) {
        print(e);
        yield const NewsErrorState(errorMessage: "Couldn't load data");
      }
    } else if (event is ReadArticleEvent) {
      if (state is NewsLoadedState) {
        final loadedState = state as NewsLoadedState;

        yield NewsLoadedState(
            allNews: loadedState.allNews,
            readNews: [...loadedState.readNews, event.newsModel]);
        await newsRepo.readArticle(event.newsModel);
      }
    } else if (event is UnReadArticleEvent) {
      final _x = state as NewsLoadedState;
      final loadedState = NewsLoadedState(
          allNews: _x.allNews,
          readNews: [..._x.readNews]);
      yield NewsInitState();

      final _removed = [...loadedState.readNews..remove(event.newsModel)];
      final newList = List<NewsArticleModel>.of(_removed);

      await newsRepo.unReadArticle(event.newsModel);
      yield NewsLoadedState(
          allNews: loadedState.allNews,
          readNews: newList.toList());
    }
  }

  @override
  void onChange(Change<NewsStates> change) {
    print(change.currentState);
    super.onChange(change);
  }

  @override
  void onEvent(NewsEvents event) {
    print(event);
    super.onEvent(event);
  }
}
