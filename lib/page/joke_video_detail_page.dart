import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class JokeVideoDetailPage extends StatefulWidget {
  final String title;
  final String video;

  JokeVideoDetailPage({Key key, this.title, this.video}) : super(key: key);
  @override
  _JokeVideoDetailPageState createState() => _JokeVideoDetailPageState();
}

class _JokeVideoDetailPageState extends State<JokeVideoDetailPage> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.video, autoPlay: true);
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Container(
          alignment: Alignment.center,
          child: FijkView(
            player: player,
            color: Colors.black,
          ),
        ));
  }
}
