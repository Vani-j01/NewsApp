import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_loader/webview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Get News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<News>> _getnews() async {
    var data =
    await http.get("https://hubblesite.org/api/v3/news");

    var jsonData = json.decode(data.body);

    List <News> news = [];

    for (var i in jsonData) {
      News obj = News(i["news_id"], i["name"], i["url"]);
      news.add(obj);
    }
    return news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:SafeArea(
          child:
              Padding(
                padding: EdgeInsets.all(16.0),

          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child:
                  Text("News Articles",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),

                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(20.0),
              ),
              Expanded(
              child: Container(
                child: FutureBuilder(
                  future: _getnews(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => WebViewClass(url: snapshot.data[index].url)),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 16.0,
                                ),
                                child: ListTile(
                                  title: Text(snapshot.data[index].name),
                                  subtitle: RichText(
                                    text: TextSpan(
                                        text: snapshot.data[index].news_id,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        children: [
                                          TextSpan(
                                            text: "\n" + snapshot.data[index].url,
                                            style: TextStyle(
                                              color: Colors.lightBlue,
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            );

                        }
                );
    }
    }

              ),
              ),
              ),

            ],
          ),
        ),
        ),
    );
  }
}


  class News{
  final String news_id;
  final String name;
  final String url;

  News(this.news_id, this.name, this.url);
}
