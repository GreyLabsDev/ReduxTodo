import 'package:redux_todo/action/ActionType.dart';
import 'package:redux_todo/action/BaseAction.dart';

class ActionAddTodo extends BaseAction {
  final String title;
  ActionAddTodo(this.title) : super(ActionType.ADD_TODO);

  static ActionAddTodo addTodo(ActionType type, String title) => ActionAddTodo(title);
}