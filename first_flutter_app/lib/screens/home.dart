import 'package:flutter/material.dart';
import 'package:first_flutter_app/screens/calculator.dart';
import 'team_list.dart';
import 'battle.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
              sayHello(),
              textDirection: TextDirection.ltr,
            ))
          ],
        ),
        SizedBox(height: 16.0),
        Calculator(),
        SizedBox(height: 16.0),
        VaporwaveImageWidget(),
        SizedBox(height: 16.0),
        NavButton(),
        OrderButton(),
        BattleButton(),
      ],
    );
  }
}

String sayHello() {
  String hello;
  DateTime now = DateTime.now();
  int hour = now.hour;
  int minute = now.minute;
  if (hour < 12) {
    hello = "Good morning.";
  } else if (hour < 18) {
    hello = "Good afternoon.";
  } else {
    hello = "Good evening.";
  }
  String minutes = (minute < 10) ? "0" + minute.toString() : minute.toString();
  return hello +
      "\n"
      "It's now " +
      hour.toString() +
      ":" +
      minutes +
      ".";
}

class VaporwaveImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage vaporwave = AssetImage('images/vaporwave_grid.png');
    Image image = Image(
      image: vaporwave,
      width: 420,
    );
    return Container(child: image);
  }
}

class OrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = Container(
        child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            child: Text("Complete the First Quest!"),
            elevation: 5.0,
            onPressed: () {
              complete(context);
            }));
    return button;
  }

  void complete(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Quest Complete!"),
      content: Text(
          "You've shown your proficiency in creating and selecting buttons!"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

class NavButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = Container(
        child: Column(children: <Widget>[
      RaisedButton(
          elevation: 10.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          onPressed: () {
            navigateToScreen(context);
          })
    ]));
    return button;
  }

  void navigateToScreen(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TeamList()));
  }
}

class BattleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = Container(
        child: Column(children: <Widget>[
      RaisedButton(
          child: Text("BATTLE!"),
          elevation: 10.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          onPressed: () {
            navigateToScreen(context);
          })
    ]));
    return button;
  }

  void navigateToScreen(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Battle()));
  }
}

class HelloUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelloUserState();
}

class _HelloUserState extends State<HelloUser> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Username",
              hintText: "Insert your name here.",
            ),
            onChanged: (String string) {
              setState(() {
                name = string;
              });
            },
          ),
          Text(
            "Hello, User_" + name + ".",
          )
        ],
      ),
    );
  }
}
