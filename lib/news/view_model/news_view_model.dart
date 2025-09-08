import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/news/data/repositories/news_repository.dart';
import 'package:news/news/view_model/news_state.dart';
import 'package:news/shared/widgets/service_locator.dart';

class NewsViewModel extends Cubit<NewsState> {
  late NewsRepository repository;
  NewsViewModel() : super(NewsInitial()) {
    repository = NewsRepository(dataSource: ServiceLocator.newsDataSource);
  }

  List<News> allNews = [];
  List<News> filteredNews = [];
  String currentQuery = '';

  List<News> get news => filteredNews;

  Future<void> getNews(String sourceId) async {
    emit(GetNewsLoading());
    try {
      allNews = await repository.getNews(sourceId);
      filteredNews = allNews;
      emit(GetNewsSuccess(news));
    } catch (error) {
      filteredNews = [];
      emit(GetNewsError(error.toString()));
    }
  }

  Future<List<News>> getAllNews() async {
    emit(GetNewsLoading());
    try {
      allNews = await repository.getAllNews();
      filteredNews = allNews;
      emit(GetNewsSuccess(filteredNews, currentQuery: currentQuery));
    } catch (error) {
      filteredNews = [];
      emit(GetNewsError(error.toString()));
    }
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
    emit(GetNewsSuccess(filteredNews, currentQuery: currentQuery));
  }
}
