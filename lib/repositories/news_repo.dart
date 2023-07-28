import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:news_test_task/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const apiKey = "";
const baseUrl = "https://newsapi.org/v2";

class NewsRepo {
  final dio = Dio();

Future<List<NewsArticleModel>> getAllNews() async {
  List<NewsArticleModel> _newsArticleList = [];
  try {
    Response response =
        await dio.get("$baseUrl/everything?q=bitcoin&apiKey=$apiKey&pageSize=5");
    var data = response.data;
    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        NewsArticleModel _newsArticleModel = NewsArticleModel.fromJson(item);
        _newsArticleList.add(_newsArticleModel);
      }
      return _newsArticleList;
    }
    return _newsArticleList;
  } catch (e) {
    return _newsArticleList;
  }
}


  Future<List<NewsArticleModel>> getReadNews() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedNews = prefs.getStringList('savedNews');
    if (savedNews == null) {
      return [];
    } else {
      return savedNews
          .map((e) => NewsArticleModel.fromJson(jsonDecode(e)))
          .toList();
    }
  }

  Future<bool> readArticle(NewsArticleModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final oldNews = await getReadNews();
    // if item is present
    if (oldNews.contains(model)) {
      return false;
    }
    final latestNews = [...oldNews, model];
    final _set = latestNews.toSet().toList();
    return await prefs.setStringList(
        'readNews', _set.map((n) => jsonEncode(n)).toList());
  }

  Future<bool> unReadArticle(NewsArticleModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final oldNews = await getReadNews();
    final news = oldNews.toSet()
      ..remove(model)
      ..toList();
    return await prefs.setStringList(
        'readNews', news.map((n) => jsonEncode(n)).toList());
  }
}
