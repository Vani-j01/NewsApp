import 'dart:convert';

import 'package:news_loader/model/ArticleModel.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> articles = [];

 Future<void> getarticles() async{
   String url = "https://hubblesite.org/api/v3/news";

   var response = await http.get(url);
   var jsonData = jsonDecode(response.body);

   for (var i in jsonData) {
     ArticleModel obj = ArticleModel(newsid: i["news_id"], url: i["url"], name: i["name"]);
     articles.add(obj);
   }
 }
}