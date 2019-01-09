import 'package:flutter/material.dart';
import 'package:first_flutter_app/model/PlayerObject.dart';
import 'dart:async';

class Battle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BattleState();
}

class BattleState extends State<Battle> {
  int playerHealth = 20;
  int playerStrength = 2;
  String playerName = "Test Object 1";

  int opponentHealth = 25;
  int opponentStrength = 3;
  String opponentName = "Test Object 2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Battle"),
      ),
      body: ListView(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(children: <Widget>[
                SizedBox(
                    height: 80,
                    child: Text(playerName, textScaleFactor: 1.75)),
                SizedBox(height: 160),
                BottomIconImageWidget(),
                SizedBox(height: 80),
                Text('HP: ' + "$playerHealth", textScaleFactor: 3),
                Text("STR: " + playerStrength.toString(), textScaleFactor: 3),
                actionItem()
              ]),
            ),
            Expanded(
              child: Column(children: <Widget>[
                SizedBox(
                  height: 80,
                  child: Text(opponentName, textScaleFactor: 1.75),
                ),
                SizedBox(height: 160),
                BottomIconImageWidget(),
                SizedBox(height: 80),
                Text('HP: ' + opponentHealth.toString(), textScaleFactor: 3),
                Text("STR: " + opponentStrength.toString(), textScaleFactor: 3),
                actionItem()
              ]),
            ),
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _doDamage();
      }),
    );
  }

  void setStats() {
    playerName = "Hypocampus";
    playerHealth = 25;
    playerStrength = 3;

    opponentName = "Test_Subject";
    opponentHealth = 40;
    opponentStrength = 30;
  }

  RaisedButton actionItem() {
    RaisedButton action;
    action = RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        child: Text("Action"),
        elevation: 10.0,
        onPressed: () {
          _takeTurn();
        });
    return action;
  }

  void _takeTurn() {
    _doDamage();

    Timer _timer = new Timer(Duration(milliseconds: 500), () {
      _enemyTurn();
    });
  }

  void _doDamage() {
    int newOpponentHealth = opponentHealth - playerStrength;
    setState(() {
      opponentHealth = newOpponentHealth;
    });
  }

  void _enemyTurn() {
    int newPlayerHealth = playerHealth - opponentStrength;
    setState(() {
      playerHealth = newPlayerHealth;
    });
  }
}

class BottomIconImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage bottom = AssetImage('images/basline_bottom.png');
    Image image = Image(
      image: bottom,
      width: 210,
    );
    return Container(child: new Icon(Icons.local_florist, size: 48));
  }
}
