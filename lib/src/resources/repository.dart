import 'dart:async';
import 'package:flutter_bloc/src/modules/movies/models/detail_model.dart';
import 'package:flutter_bloc/src/modules/movies/models/item_model.dart';
import 'package:flutter_bloc/src/modules/movies/models/trailer_model.dart';
import 'package:flutter_bloc/src/resources/movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();
  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
  Future<DetailModel> fetchMovie(id) => moviesApiProvider.fetchMovie(id);
  Future<TrailerModel> fetchTrailer(int id) => moviesApiProvider.fetchTrailer(id);
}