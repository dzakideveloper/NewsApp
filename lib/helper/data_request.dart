import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/ResponseBerita.dart';

String apiKey = "8f834b06db2e462c9e6ba35fb3ba74ca";

class News {
  Future<ResponseBerita> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=id&apiKey=$apiKey";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return ResponseBerita.fromJsonMap(jsonData);
  }
}

class NewsByCategory {
  Future<ResponseBerita> getNewsByCategory(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=id&category=$category&apiKey=$apiKey";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return ResponseBerita.fromJsonMap(jsonData);
  }
}
