import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/modules/movies/models/trailer_model.dart';
import '../models/detail_model.dart';
import '../blocs/movie_detail_bloc_provider.dart';

class MovieDetail extends StatefulWidget {
  final int id;
  final String title;

  MovieDetail({Key key, this.id, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailState(
      id: this.id,
      title: this.title
    );
  }
}

class _MovieDetailState extends State<MovieDetail>{

  final int id;
  final String title;
  MovieBloc bloc;

  _MovieDetailState({
    this.id,
    this.title
  });

  @override
  void dispose () {
    bloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailersById(this.id);
    bloc.fetchMovie(this.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchMovie(this.id);
    return Scaffold(
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
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                title: Text(
                    snapshot.data.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )
                ),
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "https://image.tmdb.org/t/p/w500${snapshot.data.poster}",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0)),
                Text(
                  snapshot.data.title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      snapshot.data.vote.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Icon(
                      Icons.date_range,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      snapshot.data.release.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(snapshot.data.overview),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                StreamBuilder(
                  stream: bloc.movieTrailers,
                  builder: (context,
                      AsyncSnapshot<Future<TrailerModel>> snapshot) {
                    if (snapshot.hasData) {
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context,
                            AsyncSnapshot<TrailerModel> itemSnapShot) {
                          if (itemSnapShot.hasData) {
                            if (itemSnapShot.data.results.length > 0)
                              return trailerLayout(itemSnapShot.data);
                            else
                              return noTrailer(itemSnapShot.data);
                          } else {
                            return Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: Center(child: Icon(Icons.play_circle_filled)),
          ),
          Text(
            data.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

