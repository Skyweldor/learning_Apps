import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:first_flutter_app/model/PlayerObject.dart';

class DbHelper {
  static final DbHelper _dbhelper = DbHelper._internal();
  String tblTeam = "team";
  String colId = "id";
  String colName = "name";
  String colDescription = "description";
  String colStrength = "strength";
  String colHealth = "health";

  String tblPlayer = "player";
  String colPlayerId = "id";
  String colPlayerName = "name";
  String colPlayerExp = "exp";
  String colPlayerStrength = "atk";
  String colPlayerHealth = "HP";

  DbHelper._internal();

  factory DbHelper() {
    return _dbhelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "team.db";
    var dbTeam = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTeam;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblTeam($colId INTEGER PRIMARY KEY, $colName TEXT, " +
            "$colDescription TEXT, $colStrength INTEGER, $colHealth INTEGER)");
    await db.execute(
        "CREATE TABLE $tblPlayer($colPlayerId INTEGER PRIMARY KEY, $colPlayerName TEXT, " +
            "$colPlayerExp INTEGER, $colPlayerStrength INTEGER, $colPlayerHealth INTEGER)");
  }

  Future<int> insertTeamMember(PlayerObject playerObject) async {
    Database db = await this.db;
    var result = await db.insert(tblTeam, playerObject.toMap());
    return result;
  }

  Future<List> getTeam() async {
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT* FROM $tblTeam order by $colHealth ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblTeam"));
    return result;
  }

  Future<int> updateTeam(PlayerObject playerObject) async {
    var db = await this.db;
    var result = await db.update(tblTeam, playerObject.toMap(),
        where: "$colId = ?", whereArgs: [playerObject.id]);
    return result;
  }

  Future<int> deleteTeamMember(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete("DELETE FROM $tblTeam WHERE $colId = $id");
    return result;
  }
}
