import 'dart:async';
import 'package:flutter_bloc/src/modules/movies/models/detail_model.dart';
import 'package:flutter_bloc/src/modules/movies/models/item_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<DetailModel> fetchMovie(id) async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$id?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200){
      return DetailModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load post');
    }
  }
}