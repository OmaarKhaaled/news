import 'package:flutter/widgets.dart';
import 'package:news/news/data/data_sources/news_data_source.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsViewModel with ChangeNotifier {
  NewsDataSource newsDataSource = NewsDataSource();
  List<News> news = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> getNews(String sourceId) async {
    isLoading = true;
    try {
      NewsResponse response = await newsDataSource.getNews(sourceId);
      if (response.status == 'ok' && response.articals != null) {
        news = response.articals!;
      } else {
        errorMessage = 'Failed to get News';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
