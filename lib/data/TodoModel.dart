import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class TodoModel {
  
  static const TABLE_NAME = "todos";

  String uuid;
  String title;
  bool isCompleted = false;
  
  TodoModel({this.uuid, this.title, this.isCompleted});

  Map<String, dynamic> toMap() {
    return {
      'uuid' : uuid,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> src) => new TodoModel(
    uuid: src['uuid'],
    title: src['title'],
    isCompleted: src['isCompleted'] == 1
  );
}