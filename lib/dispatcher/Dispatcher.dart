import 'package:redux_todo/action/ActionType.dart';
import 'package:redux_todo/action/BaseAction.dart';
import 'package:redux_todo/reducer/FilterReducer.dart';
import 'package:redux_todo/reducer/TodosReducer.dart';
import 'package:redux_todo/store/Store.dart';

class Dispatcher {
  //TODO make factory singleton
  
  var _todosReducer = TodosReducer(Store());
  var _filterReducer = FilterReducer(Store());

  void dispatch(BaseAction action) {
    switch (action.type) {
      case ActionType.ADD_TODO: {
        _todosReducer.addTodo(action);
      }
      break;
      case ActionType.REMOVE_TODO: {
        _todosReducer.removeTodo(action);
      }
      break;
      case ActionType.TOGGLE_TODO: {
        _todosReducer.toggleTodo(action);
      }
      break;
      case ActionType.SET_VISIBILITY_FILTER: {
        _filterReducer.setVisibilityFilter(action);
      }
      break;
    }
  }
}