import 'package:news/news/data/data_sources/news_api_data_source.dart';
import 'package:news/news/data/data_sources/news_data_source.dart';
import 'package:news/news/data/models/News.dart';

class NewsRepository {
  NewsDataSource dataSource;

  NewsRepository({required this.dataSource});

  Future<List<News>> getNews(String sourceId) {
    return dataSource.getNews(sourceId);
  }

  Future<List<News>> getAllNews() async {
    return await dataSource.getAllNews();
  }
}
