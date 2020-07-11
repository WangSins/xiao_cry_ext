import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class JokeDrawableDetailPage extends StatefulWidget {
  final String title;
  final String image;

  JokeDrawableDetailPage({Key key, this.title, this.image}) : super(key: key);
  @override
  _JokeDrawableDetailPageState createState() => _JokeDrawableDetailPageState();
}

class _JokeDrawableDetailPageState extends State<JokeDrawableDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: widget.image,
            errorWidget: (context, url, error) => new Center(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 100.0,
                  ),
                  Text(
                    "图片加载异常!",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
