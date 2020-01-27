import 'dart:async';

import 'package:redux_todo/data/TodoModel.dart';
import 'package:redux_todo/store/FilterType.dart';

class Store {

  Store._buildInstance() {
    this._state = _buildInitialState();
  }

  factory Store() => _storeInstance;
  static final _storeInstance = new Store._buildInstance();
  static StreamController _stateStreamController = new StreamController<StoreState>();
  Stream<StoreState> stateStream = _stateStreamController.stream;
  
  StoreState _state;

  StoreState getState() => _state;

  void updateState(StoreState newState) {
    _state = newState;
    _stateStreamController.add(newState);
  }

  static StoreState _buildInitialState() => StoreState(
    FilterType.SHOW_ALL, 
    [
      TodoModel("Buy Coke"),
      TodoModel("Go to gym"),
      TodoModel("Sleep more today"),
    ]
  );
}

class StoreState {
  final FilterType filter;
  final List<TodoModel> todos;

  StoreState(this.filter, this.todos);
}