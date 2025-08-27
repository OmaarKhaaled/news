import 'package:news/news/data/models/News.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<News>? articals;

  NewsResponse({this.status, this.totalResults, this.articals});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    articals: (json['articles'] as List<dynamic>?)
        ?.map((e) => News.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
