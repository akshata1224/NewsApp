import 'package:flutter/material.dart';
import 'package:news_app/model/ArticleModel.dart';
import 'package:news_app/news/newApp.dart';

import 'ArticleView.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<ArticleModel>articles=new List<ArticleModel>();
  bool _loading=true;

  @override
  void initState(){
    super.initState();
    getNewsApp();
  }

  getNewsApp() async{
    NewsApp newsClass=NewsApp();
    await newsClass.getNewsApp();
    articles=newsClass.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Text (
          "NewsApp",

          style: TextStyle(
            color: Colors.purple[600],
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),

        ),
        leading: Icon(
            Icons.menu,
          color: Colors.purple[600],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:_loading ? Container(
        child:CircularProgressIndicator(),
      ) : Container(
        padding:EdgeInsets.all(9.0),
        child:ListView.builder(
          itemCount: articles.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
            return BlogTile(
              imageUrl: articles[index].urlToImage,
              title: articles[index].title,
              desc: articles[index].description,
              url:articles[index].url,

            );
            }
        ),

      )

    );
  }
}

class BlogTile extends StatelessWidget {

  final String title,imageUrl,desc,url;
  BlogTile({@required this.title,@required this.desc,@required this.imageUrl,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
                blogUrl:url,

            )
        ));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 7,),
            Text(title,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),),
            SizedBox(height: 7,),
            Text(desc,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black54
            ),)
          ],
        ),
      ),
    );
  }
}
