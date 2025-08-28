import 'package:flutter/widgets.dart';
import 'package:news/news/data/data_sources/news_data_source.dart';
import 'package:news/news/data/models/News.dart';

class NewsViewModel with ChangeNotifier {
  NewsDataSource newsDataSource = NewsDataSource();
  List<News> news = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> getNews(String sourceId) async {
    isLoading = true;
    try {
     news = await newsDataSource.getNews(sourceId);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
