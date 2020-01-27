import 'package:flutter/material.dart';
import 'package:redux_todo/screen/main/ScreenMain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReduxTodo',
      home: ScreenMain(),
    );
  }
}