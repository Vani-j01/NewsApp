import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final title;

  const Category({Key key, this.title}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyle(color: Colors.black),),
          ],
        ),
      ),
      
      body: Center(
        child: Container(
          child: Text("Page Under Construction"),
        ),
      ),

    );
  }
}
