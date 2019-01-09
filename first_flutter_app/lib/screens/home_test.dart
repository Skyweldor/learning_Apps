import 'package:flutter/material.dart';
import 'package:first_flutter_app/main.dart';
import 'package:first_flutter_app/screens/team_list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TeamList(),
    );
  }
}

void navigateToScreen(BuildContext context) async {
  bool result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => HelloFlutter()));
}
