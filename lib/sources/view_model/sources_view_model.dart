import 'package:flutter/widgets.dart';
import 'package:news/shared/widgets/service_locator.dart';
import 'package:news/sources/data/data_sources/sources_api_data_source.dart';
import 'package:news/sources/data/models/source.dart';
import 'package:news/sources/data/repositories/sources_repository.dart';

class SourcesViewModel with ChangeNotifier {
  late SourcesRepository repository;

  SourcesViewModel() {
    repository = SourcesRepository(dataSource: ServiceLocator.sourcesDataSource);
  }
  List<Source> sources = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> getSources(String categoryId) async {
    isLoading = true;
    try {
      sources = await repository.getSources(categoryId);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
