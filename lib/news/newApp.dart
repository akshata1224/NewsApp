import 'dart:convert';

import 'package:news_app/model/ArticleModel.dart';
import 'package:http/http.dart' as http;

class NewsApp{

  List<ArticleModel>news=[];

  Future<void> getNewsApp() async {
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b55937b6534a4b4590ae17f4c25dca9a";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"]
          );
          news.add(articleModel);
        }
      });
    }
  }

}
