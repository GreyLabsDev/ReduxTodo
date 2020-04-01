import 'package:redux_todo/action/ActionAddTodo.dart';
import 'package:redux_todo/action/ActionRemoveTodo.dart';
import 'package:redux_todo/action/ActionToggleTodo.dart';
import 'package:redux_todo/data/TodoModel.dart';
import 'package:redux_todo/middleware/DbMiddleware.dart';
import 'package:redux_todo/store/Store.dart';
import 'package:uuid/uuid.dart';

class TodosReducer {
  final Store _store;

  TodosReducer(this._store);

  void addTodo(ActionAddTodo action) {
    var newTodo = TodoModel(uuid: Uuid().v4(), title: action.title, isCompleted: false);

    DbMiddleware().insertTodo(newTodo)
    .then((isAdded) => DbMiddleware().getTodos())
    .then((todos) {
      var previousState = _store.getState();
      var newState = StoreState(
        previousState.filter,
        todos
      );
      _store.updateState(newState);
    });
  }

  void removeTodo(ActionRemoveTodo action) {
    var previousState = _store.getState();
    var todoToRemove = previousState.todos[action.index];

    DbMiddleware().removeTodo(todoToRemove)
    .then((isRemoved) => DbMiddleware().getTodos())
    .then((todos) {
      var previousState = _store.getState();
      var newState = StoreState(
        previousState.filter,
        todos
      );
      _store.updateState(newState);
    });
  }

  void toggleTodo(ActionToggleTodo action) {
    var previousState = _store.getState();
    var todoToUpdate = previousState.todos[action.index];
    todoToUpdate.isCompleted = !todoToUpdate.isCompleted;

    DbMiddleware().insertTodo(todoToUpdate)
      .then((isAdded) => DbMiddleware().getTodos())
      .then((todos) {
        var previousState = _store.getState();
        var newState = StoreState(
          previousState.filter,
          todos
        );
        _store.updateState(newState);
    });
  }

  void initTodos() {
      DbMiddleware().getTodos()
      .then((todos) {
        var previousState = _store.getState();
        var newState = StoreState(
          previousState.filter,
          todos
        );
        _store.updateState(newState);
      });
  }

}