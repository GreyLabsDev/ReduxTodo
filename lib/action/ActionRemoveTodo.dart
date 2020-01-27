import 'package:redux_todo/action/ActionType.dart';
import 'package:redux_todo/action/BaseAction.dart';

class ActionRemoveTodo extends BaseAction {
  final int index;
  ActionRemoveTodo(this.index) : super(ActionType.REMOVE_TODO);

  static ActionRemoveTodo removeTodo(int index) => ActionRemoveTodo(index);
}