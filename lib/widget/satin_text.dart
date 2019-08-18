import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xiao_cry_ext/entity/satin_entity.dart';

class SatinText extends StatefulWidget {
  @override
  _SatinTextState createState() => _SatinTextState();
}

class _SatinTextState extends State<SatinText> {
  List<SatinData> lists = [];
  int page = 0;
  int type = 2;
  ScrollController _scrollController = new ScrollController();

  Future<void> _onRefresh() async {
    var responce = await http
        .get("https://www.apiopen.top/satinGodApi?type=$type&page=${page = 0}");
    var satin = SatinEntity.fromJson(json.decode(responce.body));
    setState(() {
      lists = satin.data;
    });
    print("SatinText_onRefresh:${lists.length}");
  }

  _initData() async {
    var responce = await http
        .get("https://www.apiopen.top/satinGodApi?type=$type&page=${page = 0}");
    var satin = SatinEntity.fromJson(json.decode(responce.body));
    setState(() {
      lists = satin.data;
    });
    print("SatinText_initData:${lists.length}");
  }

  _loadMore() async {
    var responce = await http
        .get("https://www.apiopen.top/satinGodApi?type=$type&page=${++page}");
    var satin = SatinEntity.fromJson(json.decode(responce.body));
    setState(() {
      lists.addAll(satin.data);
    });
    print("SatinText_loadMore:${lists.length}");
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
          color: Colors.grey,
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: 4,
            itemCount: lists.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(lists[index].text),
                      Text(
                        "热评：${lists[index].topCommentsContent ?? "暂无热评"}",
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
