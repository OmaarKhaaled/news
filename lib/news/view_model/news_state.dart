import 'package:news/news/data/models/News.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class GetNewsLoading extends NewsState {}

class GetNewsError extends NewsState {
  String message;

  GetNewsError(this.message);
}

class GetNewsSuccess extends NewsState {
  List<News> news;
  String currentQuery;

  GetNewsSuccess(this.news, {this.currentQuery = ''});
}
