import 'package:flutter/material.dart';
import 'package:first_flutter_app/model/PlayerObject.dart';
import 'package:first_flutter_app/util/DbHelper.dart';
import 'package:first_flutter_app/screens/playerObjectDetail.dart';

class TeamList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TeamListState();
}

class TeamListState extends State {
  DbHelper helper = DbHelper();
  List<PlayerObject> team;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (team == null) {
      team = List<PlayerObject>();
      getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
      ),
      body: teamListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToScreen(new PlayerObject("", 5, 15));
        },
        tooltip: "There are hidden secrets afoot.",
        child: new Icon(Icons.call_split),
      ),
    );
  }



  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final teamFuture = helper.getTeam();
      teamFuture.then((result) {
        List<PlayerObject> teamList = List<PlayerObject>();
        count = result.length;
        for (int i = 0; i < count; i++) {
          teamList.add(PlayerObject.fromObject(result[i]));
        }
        setState(() {
          team = teamList;
          count = count;
        });
      });
    });
  }

  ListView teamListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.black26,
          elevation: 5.0,
          child: objectDescriptor(position),
        );
      },
    );
  }

  ListTile objectDescriptor(int position) {
    ListTile objectListTile = ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Text(this.team[position].id.toString()),
      ),
      title: Text(showName(this.team[position])),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            child: Text(showDescription(this.team[position])),
            flex: 5,
          ),
          Expanded(child: Text("HP: " + this.team[position].health.toString())),
          Expanded(
              child: Text("STR: " + this.team[position].strength.toString()))
        ],
      ),
      onTap: () {
        navigateToScreen(this.team[position]);
      },
    );

    return objectListTile;
  }

  String showName(PlayerObject playerObject) {
    String name = "";
    if (playerObject.name != null) {
      name = playerObject.name;
    }
    return name;
  }

  String showDescription(PlayerObject playerObject) {
    String description = "";
    if (playerObject.description != null) {
      description = playerObject.description;
    }
    return description;
  }

  void navigateToScreen(PlayerObject playerObject) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlayerObjectDetail(playerObject)));
    if (result == true) {
      getData();
    }
  }
}
