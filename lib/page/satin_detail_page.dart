import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SatinDetailPage extends StatefulWidget {
  final String title;
  final String gif;
  final String image;

  SatinDetailPage({Key key, this.title, this.gif, this.image})
      : super(key: key);
  @override
  _SatinDetailPageState createState() => _SatinDetailPageState();
}

class _SatinDetailPageState extends State<SatinDetailPage> {
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.0),
        child: Center(
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: widget.image ?? widget.gif,
            errorWidget: (context, url, error) => new Center(
              child: Icon(
                Icons.broken_image,
                size: 160,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
