import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbMiddleware {
  DbMiddleware._buildInstance();

  factory DbMiddleware() => _instance;
  static final _instance = new DbMiddleware._buildInstance();

  static const _DB_NAME = "redux_todo.db";
  Database _database;
  
  Future<Database> get _getDatabase async {
    if (_database != null) {
      return _database;
    } else {
      _database = await init();
      return _database;
    }
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path.toString() + _DB_NAME;
    return await openDatabase(
      path, 
      version: 1, 
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Todos ("
          "uuid TEXT PRIMARY KEY,"
          "title TEXT,"
          "isCompleted INTEGER"
          ")");
    });
  }
}