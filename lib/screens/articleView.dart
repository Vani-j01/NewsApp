import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  final String postUrl, title;
  ArticleView({@required this.postUrl, @required this.title});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  bool loading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Fresh",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
        // Opacity(
        // opacity:0,)
          GestureDetector(
              onTap: (){
                Share.share(widget.postUrl, subject: 'Check out this News!!');
              },child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share, color: Colors.blue,))),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:Scaffold(

        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
            initialUrl:  widget.postUrl,
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
          ),
        ),
      )




    );
  }
}