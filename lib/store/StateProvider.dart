import 'package:redux_todo/store/Store.dart';

class StateProvider {
  // its like repository, non singleton
  Store _store = Store();

  Stream<StoreState> getStateStream() => _store.stateStream;
  StoreState getPreviousState() => _store.getState();
}