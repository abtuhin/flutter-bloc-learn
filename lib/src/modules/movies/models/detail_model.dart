class DetailModel {
  int _budget;
  String _lang;
  String _title;
  String _overview;
  double _popularity;

  DetailModel.fromJson(Map<String, dynamic> parsedJson){
    _budget = parsedJson["budget"];
    _title = parsedJson["original_title"];
    _lang = parsedJson["original_language"];
    _overview = parsedJson["overview"];
    _popularity = parsedJson["popularity"];
  }

  int get budget => _budget;
  double get popularity => _popularity;
  String get lang => _lang;
  String get title => _title;
  String get overview => _overview;
}