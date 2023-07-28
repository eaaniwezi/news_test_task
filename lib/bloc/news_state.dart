part of 'news_bloc.dart';

class NewsStates extends Equatable {
  const NewsStates();

  @override
  List<Object?> get props => [];
}

class NewsInitState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsLoadedState extends NewsStates {
  final List<NewsArticleModel> allNews;
  final List<NewsArticleModel> readNews;
  const NewsLoadedState({
    required this.allNews,
    required this.readNews,
  });
  @override
  List<Object?> get props => [...readNews];
}

class NewsErrorState extends NewsStates {
  final String errorMessage;
  const NewsErrorState({required this.errorMessage});
}
