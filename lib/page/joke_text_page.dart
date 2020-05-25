import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xiao_cry_ext/constant/api_constant.dart';
import 'package:xiao_cry_ext/entity/joke_entity.dart';

class JokeTextPage extends StatefulWidget {
  @override
  _JokeTextPageState createState() => _JokeTextPageState();
}

class _JokeTextPageState extends State<JokeTextPage> {
  List<JokeResult> _lists = [];
  int _page = 0;
  ScrollController _scrollController = new ScrollController();

  Future<void> _onRefresh() async {
    var _responce = await http.get(APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_TEXT}&page=${_page = 0}");
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      _lists = _joke.result;
    });
    print("JokeTextPage_onRefresh:${_lists.length}");
  }

  _initData() async {
    var _responce = await http.get(APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_TEXT}&page=${_page = 0}");
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      _lists = _joke.result;
    });
    print("JokeTextPage_initData:${_lists.length}");
  }

  _loadMore() async {
    var _responce = await http.get(APIConstant.BASE_URL +
        APIConstant.ACTION_GET_JOKE +
        "?type=${APIConstant.TYPE_TEXT}&page=${++_page}");
    var _joke = JokeEntity.fromJson(json.decode(_responce.body));
    setState(() {
      _lists.addAll(_joke.result);
    });
    print("JokeTextPage_loadMore:${_lists.length}");
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
              return Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_lists[index].text),
                      Text(
                        "热评：${_lists[index].topCommentsContent ?? "暂无热评"}",
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 12.0),
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
