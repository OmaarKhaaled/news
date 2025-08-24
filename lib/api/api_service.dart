import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/api/api_constans.dart';
import 'package:news/models/news_response/news_response.dart';
import 'package:news/models/sources_response/sources_response.dart';

class ApiService {
  static Future<SourcesResponse> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstans.baseUrl, ApiConstans.sourcesEndPoint, {
      'apiKey': ApiConstans.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }

  static Future<NewsResponse> getNews(String sourceId) async {
    Uri uri = Uri.https(ApiConstans.baseUrl, ApiConstans.newsEndPoint, {
      'apiKey': ApiConstans.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
