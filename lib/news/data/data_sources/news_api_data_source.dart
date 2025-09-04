import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/news/data/data_sources/news_data_source.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/shared/constants/api_constans.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsApiDataSource implements NewsDataSource{
  @override
  Future<List<News>> getNews(String sourceId) async {
    Uri uri = Uri.https(ApiConstans.baseUrl, ApiConstans.newsEndPoint, {
      'apiKey': ApiConstans.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    if (newsResponse.status == 'ok' && newsResponse.articles != null) {
      return newsResponse.articles!;
    } else {
      throw Exception('Failed to get News');
    }
  }

  Future<List<News>> getAllNews() async {
    Uri uri = Uri.https(ApiConstans.baseUrl, ApiConstans.newsEndPoint, {
      'apiKey': ApiConstans.apiKey,
      'country': 'us',
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);

    if (newsResponse.status == 'ok' && newsResponse.articles != null) {
      return newsResponse.articles!;
    } else {
      throw Exception('Failed to get All News');
    }
  }

}
