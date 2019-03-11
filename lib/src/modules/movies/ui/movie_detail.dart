import 'package:flutter/material.dart';
import '../models/detail_model.dart';
import '../blocs/movie_bloc.dart';

class MovieDetail extends StatelessWidget {

  final int id;
  final String title;

  MovieDetail({Key key, this.id, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchMovie(this.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: StreamBuilder(
        stream: bloc.movie,
        builder: (context, AsyncSnapshot<DetailModel> snapshot){
          if (snapshot.hasData) {
            return movie(snapshot, context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }

  Widget movie(AsyncSnapshot<DetailModel> snapshot, BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width/1.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://image.tmdb.org/t/p/w185${snapshot.data.poster}'),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text(snapshot.data.title,textAlign: TextAlign.left, style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(snapshot.data.overview,textAlign: TextAlign.justify, style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70
                ))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Budget ${snapshot.data.budget.toString()}",textAlign: TextAlign.justify, style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueAccent
                ))),
          ],
        )
      ),
    );
  }

}

