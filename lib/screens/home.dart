import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_loader/helper/data.dart';
import 'package:news_loader/helper/news.dart';
import 'package:news_loader/model/ArticleModel.dart';
import 'package:news_loader/model/category_model.dart';
import 'package:news_loader/screens/articleView.dart';
import 'package:news_loader/screens/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();

    getNews();
  }

  var newslist;
  bool _loading = true;

  void getNews() async {
    News newsClass = News();
    await newsClass.getarticles();
    newslist = newsClass.articles;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Fresh", style: TextStyle(color: Colors.black)),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    ///Categories
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      height: 74.0,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].categoryImage,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),

                    ///News
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: newslist.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NewsTile(
                              title: newslist[index].name,
                              date: newslist[index].newsid,
                              url: newslist[index].url,
                              index: index,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  const CategoryTile({Key key, this.imageUrl, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(
            builder: (context) =>Category(
              title: categoryName,
            ),),);
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 16,
        ),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl,
                  width: 120.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String title, date, url;
 final int index;

  const NewsTile({Key key, this.title, this.date, this.url, this.index}) : super(key: key);
  
 
  @override
  Widget build(BuildContext context) {
    Color color;
    if(index%2 ==0){
      color = Colors.amberAccent;
    }
    else{
       color = Colors.green;
    }
    return Container(
        child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      postUrl: url,
                  title: title,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Container(
            margin: EdgeInsets.only(
              right: 10.0,
              left: 10.0,
            ),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(
                  height: 4,
                ),
                Text(
                  "Published on: "+ date,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
