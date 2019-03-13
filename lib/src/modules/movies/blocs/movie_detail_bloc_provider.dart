import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/modules/movies/blocs/movie_bloc.dart';
export 'package:flutter_bloc/src/modules/movies/blocs/movie_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget {
  final MovieBloc bloc;

  MovieDetailBlocProvider({Key key, Widget child})
      : bloc = MovieBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static MovieBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MovieDetailBlocProvider)
    as MovieDetailBlocProvider)
        .bloc;
  }
}