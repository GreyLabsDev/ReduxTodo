import 'package:uuid/uuid.dart';

class TodoModel {
  String uuid;
  String title;
  bool isCompleted = false;
  TodoModel(this.title) {
    this.uuid = Uuid().v4();
  } 
}