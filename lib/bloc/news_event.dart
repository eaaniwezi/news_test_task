part of 'news_bloc.dart';

abstract class NewsEvents extends Equatable {
  const NewsEvents();

  @override
  List<Object> get props => [];
}

class StartEvent extends NewsEvents {}

class ReadArticleEvent extends NewsEvents {
  final NewsArticleModel newsModel;
  const ReadArticleEvent({
    required this.newsModel,
  });
}

class UnReadArticleEvent extends NewsEvents {
  final NewsArticleModel newsModel;
  const UnReadArticleEvent({
    required this.newsModel,
  });
}
