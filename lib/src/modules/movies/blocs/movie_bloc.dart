import 'package:flutter_bloc/src/modules/movies/models/detail_model.dart';
import 'package:flutter_bloc/src/modules/movies/models/trailer_model.dart';
import 'package:flutter_bloc/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _repository = Repository();

  final _movieFetcher = PublishSubject<DetailModel>();
  Observable<DetailModel> get movie => _movieFetcher.stream;

  final _movieId = PublishSubject<int>();
  Function(int) get fetchTrailersById => _movieId.sink.add;

  final _trailers = BehaviorSubject<Future<TrailerModel>>();
  Observable<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  MovieBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  // to get the detail from api
  fetchMovie(id) async {
    DetailModel detailModel = await _repository.fetchMovie(id);
    _movieFetcher.sink.add(detailModel);
  }

  // remove memory leak
  dispose() async{
    await _movieFetcher.drain();
    _movieFetcher.close();
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer(){
    return ScanStreamTransformer(
          (Future<TrailerModel> trailer, int id, int index) {
        trailer = _repository.fetchTrailer(id);
        return trailer;
      },
    );
  }
}
