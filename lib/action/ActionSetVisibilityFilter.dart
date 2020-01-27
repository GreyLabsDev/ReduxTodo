import 'package:redux_todo/action/ActionType.dart';
import 'package:redux_todo/action/BaseAction.dart';
import 'package:redux_todo/store/FilterType.dart';

class ActionSetVisibilityFilter extends BaseAction {
  final FilterType filterType;
  ActionSetVisibilityFilter(this.filterType) : super(ActionType.SET_VISIBILITY_FILTER);

  static ActionSetVisibilityFilter setVisibilityFilter(FilterType filterType) {
    return ActionSetVisibilityFilter(filterType);
  }
}