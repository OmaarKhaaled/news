import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/shared/api_constans.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsDataSource {
  
   Future<NewsResponse> getNews(String sourceId) async {
    Uri uri = Uri.https(ApiConstans.baseUrl, ApiConstans.newsEndPoint, {
      'apiKey': ApiConstans.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}