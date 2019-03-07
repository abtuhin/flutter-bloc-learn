import 'package:flutter_bloc/src/modules/movies/models/detail_model.dart';
import 'package:flutter_bloc/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _repository = Repository();
  final _movieFetcher = PublishSubject<DetailModel>();
  Observable<DetailModel> get movie => _movieFetcher.stream;

  fetchMovie(id) async {
    DetailModel detailModel = await _repository.fetchMovie(id);
    _movieFetcher.sink.add(detailModel);
  }

  dispose() {
    _movieFetcher.close();
  }
}

final bloc = MovieBloc();