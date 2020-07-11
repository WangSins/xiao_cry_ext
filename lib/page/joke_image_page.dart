import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xiao_cry_ext/constant/api_constant.dart';
import 'package:xiao_cry_ext/entity/joke_entity.dart';
import 'package:xiao_cry_ext/page/joke_drawable_detail_page.dart';

class JokeImagePage extends StatefulWidget {
  @override
  _JokeImageState createState() => _JokeImageState();
}

class _JokeImageState extends State<JokeImagePage> {
  List<JokeResult> _lists = [];
  int _page = 1;
  ScrollController _scrollController = new ScrollController();
  bool _showFBA = false;

  Future<void> _onRefresh() async {
    var _responce = await http.get(APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_IMAGE}&count=${APIConstant.DEFAULT_COUNT}&page=${_page = 1}");
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      _lists = _joke.result;
    });
  }

  _loadMore(var isRefresh) async {
    var _url = APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_IMAGE}&count=${APIConstant.DEFAULT_COUNT}&page=${isRefresh ? _page = 1 : ++_page}";
    var _responce = await http.get(_url);
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      if (isRefresh) {
        _lists = _joke.result;
      } else {
        _lists.addAll(_joke.result);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMore(true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore(false);
      }
      if (_scrollController.offset >
          _scrollController.position.minScrollExtent) {
        setState(() {
          _showFBA = true;
        });
      } else {
        setState(() {
          _showFBA = false;
        });
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
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        constraints:
                            BoxConstraints(minHeight: 100.0, maxHeight: 150.0),
                        child: Center(
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: _lists[index].images,
                            placeholder: (context, url) => new Container(
                              padding: EdgeInsets.all(6.0),
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => new Icon(
                              Icons.broken_image,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.0, right: 4.0, bottom: 2.0),
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
      floatingActionButton: !_showFBA
          ? null
          : FloatingActionButton(
              onPressed: () {
                _scrollController.jumpTo(0);
              },
              child: Icon(
                Icons.arrow_upward,
              ),
              backgroundColor: Colors.grey[100],
              heroTag: APIConstant.TYPE_IMAGE,
            ),
    );
  }
}
