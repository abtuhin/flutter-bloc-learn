import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/modules/movies/ui/movie_list.dart';
import 'package:flutter_bloc/src/modules/movies/ui/movie_detail.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: MovieList(),
        ),
      );
  }
}