import 'package:flutter/material.dart';
import 'package:xiao_cry_ext/widget/satin_gif.dart';
import 'package:xiao_cry_ext/widget/satin_image.dart';
import 'package:xiao_cry_ext/widget/satin_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XiaoCry Extend',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'XiaoCry Extend Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[SatinText(), SatinImage(), SatinGif()],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapHandler,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.tag_faces), title: Text('SatinText')),
          BottomNavigationBarItem(
              icon: Icon(Icons.image), title: Text('SatinImage')),
          BottomNavigationBarItem(
              icon: Icon(Icons.gif), title: Text('SatinGif')),
        ],
      ),
    );
  }
}
