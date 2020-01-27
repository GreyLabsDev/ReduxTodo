import 'package:redux_todo/action/ActionType.dart';
import 'package:redux_todo/action/BaseAction.dart';

class ActionToggleTodo extends BaseAction {
  final int index;
  ActionToggleTodo(this.index) : super(ActionType.TOGGLE_TODO);

  static ActionToggleTodo toggleTodo(int index) => ActionToggleTodo(index);
}