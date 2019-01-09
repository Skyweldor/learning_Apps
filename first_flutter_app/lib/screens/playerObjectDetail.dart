import 'package:flutter/material.dart';
import 'package:first_flutter_app/model/PlayerObject.dart';
import 'package:first_flutter_app/util/DbHelper.dart';
import 'package:intl/intl.dart';

DbHelper helper = DbHelper();

final List<String> choices = const <String>[
  "Save Object & Back",
  "Delete Object",
  "Back to Inventory"
];

const mnuSave = "Save Object & Back";
const mnuDelete = "Delete Object";
const mnuBack = "Back to Inventory";

class PlayerObjectDetail extends StatefulWidget {
  final PlayerObject playerObject;

  PlayerObjectDetail(this.playerObject);

  @override
  State<StatefulWidget> createState() => PlayerObjectDetailState(playerObject);
}

class PlayerObjectDetailState extends State {
  PlayerObject playerObject;

  PlayerObjectDetailState(this.playerObject);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String name = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    //nameController.text = playerObject.name;
    //descriptionController.text = playerObject.description;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(playerObject.name),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(children: <Widget>[
          SizedBox(height: 16.0),
          TextField(
            controller: nameController,
            onChanged: (value) => this.updateName(),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: descriptionController,
            onChanged: (value) => this.updateDescription(),
          ),
          SizedBox(height: 32.0),
          Column(children: <Widget>[
            Text(showName(), textScaleFactor: 2, textAlign: TextAlign.right,),
            Text(showDescription(), textScaleFactor: 1.5,
                textAlign: TextAlign.left),
            Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Expanded(
                  child: Text(
                    "STR: " + playerObject.strength.toString(),
                    textScaleFactor: 1.5,
                  )),
              Expanded(
                  child: Text(
                    "HP: " + playerObject.health.toString(),
                    textScaleFactor: 1.5,
                  )),
            ])
          ]),
        ]));
  }

  void select(String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (playerObject.id == null) {
          return;
        }
        result = await helper.deleteTeamMember(playerObject.id);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Erasing Object"),
            content: Text("The object has been erasaed."),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case mnuBack:
        Navigator.pop(context, true);
        break;
    }
  }

  void save() {
    if (playerObject.id != null) {
      helper.updateTeam(playerObject);
    } else {
      helper.insertTeamMember(playerObject);
    }
    Navigator.pop(context, true);
  }

  void updateName() {
    playerObject.name = nameController.text;
    setState(() {
      name = playerObject.name;
    });
  }

  void updateDescription() {
    playerObject.description = descriptionController.text;
    setState(() {
      description = playerObject.description;
    });
  }

  String showName() {
    if (playerObject.name != null) {
      name = playerObject.name;
    }
    return name;
  }

  String showDescription() {
    if (playerObject.description != null) {
      description = playerObject.description;
    }
    return description;
  }
}
