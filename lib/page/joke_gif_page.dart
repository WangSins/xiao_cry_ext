import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xiao_cry_ext/constant/api_constant.dart';
import 'package:xiao_cry_ext/entity/joke_entity.dart';
import 'package:xiao_cry_ext/page/joke_detail_page.dart';

class JokeGifPage extends StatefulWidget {
  @override
  _JokeGifPageState createState() => _JokeGifPageState();
}

class _JokeGifPageState extends State<JokeGifPage> {
  List<JokeResult> _lists = [];
  int _page = 0;
  ScrollController _scrollController = new ScrollController();

  Future<void> _onRefresh() async {
    var _responce = await http.get(APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_GIF}&page=${_page = 0}");
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      _lists = _joke.result;
    });
    print("JokeGifPage_onRefresh:${_lists.length}");
  }

  _initData() async {
    var _responce = await http.get(APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_GIF}&page=${_page = 0}");
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      _lists = _joke.result;
    });
    print("JokeGifPage_initData:${_lists.length}");
  }

  _loadMore() async {
    var _responce = await http.get(APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_GIF}&page=${++_page}");
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      _lists.addAll(_joke.result);
    });
    print("JokeGifPage_loadMore:${_lists.length}");
  }

  @override
  void initState() {
    super.initState();
    _initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
          color: Colors.grey,
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: 4,
            itemCount: _lists.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext ctx) {
                    return new JokeDetailPage(
                      title: _lists[index].text,
                      image: _lists[index].images,
                    );
                  }));
                },
                child: Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: _lists[index].images,
                            placeholder: (context, url) => new Container(
                              padding: EdgeInsets.all(6.0),
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => new Icon(
                              Icons.broken_image,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_lists[index].text),
                            Text(
                              "热评：${_lists[index].topCommentsContent ?? "暂无热评"}",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          ),
          onRefresh: _onRefresh),
    );
  }
}
