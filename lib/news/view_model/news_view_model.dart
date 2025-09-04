import 'package:flutter/widgets.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/news/data/repositories/news_repository.dart';
import 'package:news/shared/widgets/service_locator.dart';

class NewsViewModel with ChangeNotifier {
  late NewsRepository repository;
  NewsViewModel() {
    repository = NewsRepository(dataSource: ServiceLocator.newsDataSource);
  }

  List<News> allNews = [];
  List<News> filteredNews = [];
  String currentQuery = '';

  String? errorMessage;
  bool isLoading = false;

  List<News> get news => filteredNews;

  Future<void> getNews(String sourceId) async {
    isLoading = true;
    notifyListeners();
    try {
      allNews = await repository.getNews(sourceId);
      filteredNews = allNews;
    } catch (error) {
      errorMessage = error.toString();
      filteredNews = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<List<News>> getAllNews() async {
    isLoading = true;
    notifyListeners();
    try {
      allNews = await repository.getAllNews();

      filteredNews = allNews;
    } catch (error) {
      filteredNews = [];
    }

    isLoading = false;
    notifyListeners();
    return allNews;
  }

  void filterNews(String query) {
    currentQuery = query;
    if (allNews.isEmpty) return;

    if (query.isEmpty) {
      filteredNews = allNews;
    } else {
      final q = query.toLowerCase();
      filteredNews = allNews.where((newsItem) {
        final title = (newsItem.title ?? '').toLowerCase();
        final description = (newsItem.description ?? '').toLowerCase();
        final content = (newsItem.content ?? '').toLowerCase();
        return title.contains(q) ||
            description.contains(q) ||
            content.contains(q);
      }).toList();
    }
    notifyListeners();
  }
}
