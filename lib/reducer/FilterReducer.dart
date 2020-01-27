import 'package:redux_todo/action/ActionSetVisibilityFilter.dart';
import 'package:redux_todo/store/Store.dart';

class FilterReducer {
  final Store _store;

  FilterReducer(this._store);

  void setVisibilityFilter(ActionSetVisibilityFilter action) {
    var previousState = _store.getState();
    var newState = StoreState(
      action.filterType,
      previousState.todos
    );
    _store.updateState(newState);
  }
}