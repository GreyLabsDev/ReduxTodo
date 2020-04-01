import 'package:redux_todo/action/ActionType.dart';
import 'package:redux_todo/action/BaseAction.dart';

class ActionInitTodos extends BaseAction {
  
  ActionInitTodos() : super(ActionType.INIT_TODOS);
  
  static ActionInitTodos initTodos() => ActionInitTodos();

}