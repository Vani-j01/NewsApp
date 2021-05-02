import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class WebViewClass extends StatefulWidget {
  final String url;
  WebViewClass({Key key, @required this.url}) : super(key: key);

  @override
  _WebViewClassState createState() => _WebViewClassState(newsurl: url);
}

class _WebViewClassState extends State<WebViewClass> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  String newsurl;
  _WebViewClassState({Key key, @required this.newsurl}) ;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Full Article"),
      ),
      body:
        WebView(
        initialUrl: newsurl,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),

    );
  }
}

