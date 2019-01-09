import 'package:flutter/material.dart';
import './screens/home.dart';
import 'screens/home_test.dart';
import 'screens/themes.dart';
import 'package:first_flutter_app/model/PlayerObject.dart';
import 'package:first_flutter_app/util/DbHelper.dart';

void main() => runApp(new HelloFlutter());

final ThemeData neoAppTheme = buildTheme();

class HelloFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter_Test",
      theme: neoAppTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("NeoHome"),
        ),
        body: Home(),
      ),
    );
  }
}