import 'package:flutter/material.dart';
import 'package:news_app/helper/data_request.dart';
import 'package:news_app/helper/widget.dart';
import 'package:news_app/models/ResponseBerita.dart';
import 'package:news_app/news_item.dart';

class NewsByCategories extends StatefulWidget {
  final String newsCategory;

  NewsByCategories({this.newsCategory});

  @override
  _NewsByCategoryState createState() => _NewsByCategoryState(newsCategory);
}

class _NewsByCategoryState extends State<NewsByCategories> {
  NewsByCategory newsByCategory = NewsByCategory();
  String newsCategory;

  _NewsByCategoryState(this.newsCategory);

  @override
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: myAppBar(),
      body: FutureBuilder(
          future: newsByCategory.getNewsByCategory(newsCategory),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListNewsCategory(snapshot.data);
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Data Tidak Ditemukan"));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class ListNewsCategory extends StatelessWidget {
  ResponseBerita responseBerita;

  ListNewsCategory(this.responseBerita);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        child: ListView.builder(
            itemCount: responseBerita.articles.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return NewsItem(
                imgUrl: responseBerita.articles[index].urlToImage ?? "",
                title: responseBerita.articles[index].title ?? "",
                desc: responseBerita.articles[index].description ?? "",
                content: responseBerita.articles[index].content ?? "",
                posturl: responseBerita.articles[index].url ?? "",
                name: responseBerita.articles[index].source.name,
              );
            }),
      ),
    );
  }
}
