import 'package:news/news/data/models/News.dart';

abstract class NewsDataSource {
  Future<List<News>> getNews(String sourceId);

  Future<List<News>> getAllNews();
}
