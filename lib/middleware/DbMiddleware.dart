import 'package:path/path.dart';
import 'package:redux_todo/data/TodoModel.dart';
import 'package:sqflite/sqflite.dart';

class DbMiddleware {
  DbMiddleware._buildInstance();

  factory DbMiddleware() => _instance;
  static final _instance = new DbMiddleware._buildInstance();

  static const _DB_NAME = "redux_todo.db";
  static const _DB_VERSION = 1;

  Database _database;
  
  Future<Database> get _getDatabase async {
    if (_database != null) {
      return _database;
    } else {
      _database = await init();
      return _database;
    }
  }

  Future<Database> init() async {
    return openDatabase(
      join(await getDatabasesPath(), _DB_NAME),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE ${TodoModel.TABLE_NAME}(uuid TEXT PRIMARY KEY, title TEXT, isCompleted INTEGER)"
        );
      },
      version: _DB_VERSION
    );
  }

  Future<bool> insertTodo(TodoModel todo) async {
    await _getDatabase..insert(
        TodoModel.TABLE_NAME, 
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
  }

  Future<List<TodoModel>> getTodos() async {
    var db = await _getDatabase;
    List<Map<String, dynamic>> maps = await db.query(TodoModel.TABLE_NAME);
    return List.generate(maps.length, (index) {
      return TodoModel.fromMap(maps[index]);
    })..sort((a, b) {
      return a.title.compareTo(b.title);
    });
  }

  Future<bool> removeTodo(TodoModel todo) async {
    await _getDatabase..delete(
      TodoModel.TABLE_NAME,
      where: 'uuid = ?',
      whereArgs: [todo.uuid],
    );
    return true;
  }
}