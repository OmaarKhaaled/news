import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/shared/constants/api_constans.dart';
import 'package:news/sources/data/data_sources/sources_data_source.dart';
import 'package:news/sources/data/models/source.dart';
import 'package:news/sources/data/models/sources_response.dart';

class SourcesApiDataSource implements SourcesDataSource {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstans.baseUrl, ApiConstans.sourcesEndPoint, {
      'apiKey': ApiConstans.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    if (sourcesResponse.status == 'ok' && sourcesResponse.sources != null) {
      return sourcesResponse.sources!;
    } else {
      return throw Exception('Failed to get sources');
    }
  }
}
