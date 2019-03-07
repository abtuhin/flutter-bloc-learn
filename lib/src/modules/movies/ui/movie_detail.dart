import 'package:flutter/material.dart';
import '../models/detail_model.dart';
import '../blocs/movie_bloc.dart';

class MovieDetail extends StatelessWidget {

  final int id;

  MovieDetail({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchMovie(this.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
      ),
      body: StreamBuilder(
        stream: bloc.movie,
        builder: (context, AsyncSnapshot<DetailModel> snapshot){
          if (snapshot.hasData) {
            return movie(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }

  Widget movie(AsyncSnapshot<DetailModel> snapshot) {
    return Text(snapshot.data.overview);
  }

}

