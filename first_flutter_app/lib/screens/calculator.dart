import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController seedController = TextEditingController();
  String name = "";
  String seedNumber = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(child: helloUser()),
          Expanded(child: calculatorInterface())
        ]),
        goButton(),
      ]),
    );
  }

  RaisedButton goButton() {
    return RaisedButton(
      child: Text("CALCULATE"),
      elevation: 10.0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0)),
      onPressed: _stateUpdate,
    );
  }

  void _stateUpdate() {
    setState(() {
      seedNumber = seedController.text;
    });
  }

  Container helloUser() {
    return Container(
      child: Column(children: <Widget>[
        TextField(
            decoration: InputDecoration(
              labelText: "Username",
              hintText: "Insert your name here.",
            ),
            onChanged: (String string) {
              setState(() {
                name = string;
              });
            }),
        Text("Hello, User_" + name + ".")
      ]),
    );
  }

  Container calculatorInterface() {
    return Container(
      child: Column(children: <Widget>[
        TextField(
          style:
              TextStyle(color: Colors.white, fontFamily: "Major Mono Display"),
          controller: seedController,
          decoration: InputDecoration(
            labelText: "Strength Seed Number",
            hintText: "There are perfect numbers.",
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 8.0),
        Text("Begin calculating #: " + seedNumber,
            style: TextStyle(color: Colors.white))
      ]),
    );
  }
}
