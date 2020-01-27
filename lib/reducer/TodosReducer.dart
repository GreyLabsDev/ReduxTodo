import 'package:redux_todo/action/ActionAddTodo.dart';
import 'package:redux_todo/action/ActionRemoveTodo.dart';
import 'package:redux_todo/action/ActionToggleTodo.dart';
import 'package:redux_todo/data/TodoModel.dart';
import 'package:redux_todo/store/Store.dart';

class TodosReducer {
  final Store _store;

  TodosReducer(this._store);

  void addTodo(ActionAddTodo action) {
    var previousState = _store.getState();
    var newState = StoreState(
      previousState.filter,
      previousState.todos..add(TodoModel(action.title))
    );
    _store.updateState(newState);
  }

  void removeTodo(ActionRemoveTodo action) {
    var previousState = _store.getState();
    var newState = StoreState(
      previousState.filter,
      previousState.todos..removeAt(action.index)
    );
    _store.updateState(newState);
  }

  void toggleTodo(ActionToggleTodo action) {
    var previousState = _store.getState();
    var newState = StoreState(
      previousState.filter,
      previousState.todos..[action.index].isCompleted = !previousState.todos[action.index].isCompleted
    );
    _store.updateState(newState);
  }
}