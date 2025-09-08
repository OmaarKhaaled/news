import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/widgets/service_locator.dart';
import 'package:news/sources/data/models/source.dart';
import 'package:news/sources/data/repositories/sources_repository.dart';
import 'package:news/sources/view_model/sources_state.dart';

class SourcesViewModel extends Cubit<SourcesState> {
  late SourcesRepository repository;

  SourcesViewModel() : super(SourcesInitial()) {
    repository = SourcesRepository(
      dataSource: ServiceLocator.sourcesDataSource,
    );
  }

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoading());
    try {
      List<Source> sources = await repository.getSources(categoryId);
      emit(GetSourcesSuccess(sources));
    } catch (error) {
      emit(GetSourcesError(error.toString()));
    }
  }
}
