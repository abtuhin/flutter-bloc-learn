class DetailModel {
  int _vote;
  int _budget;
  String _lang;
  String _title;
  String _overview;
  String _poster;
  String _release;
  double _popularity;

  DetailModel.fromJson(Map<String, dynamic> parsedJson){
    _budget = parsedJson["budget"];
    _title = parsedJson["original_title"];
    _lang = parsedJson["original_language"];
    _overview = parsedJson["overview"];
    _popularity = parsedJson["popularity"];
    _poster =parsedJson["backdrop_path"];
    _vote = parsedJson["vote_count"];
    _release = parsedJson["release_date"];
  }

  int get budget => _budget;
  int get vote => _vote;
  double get popularity => _popularity;
  String get lang => _lang;
  String get title => _title;
  String get overview => _overview;
  String get poster => _poster;
  String get release => _release;
}