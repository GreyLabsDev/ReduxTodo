
import 'package:flutter/material.dart';
import 'package:redux_todo/action/ActionAddTodo.dart';
import 'package:redux_todo/action/ActionInitTodos.dart';
import 'package:redux_todo/action/ActionRemoveTodo.dart';
import 'package:redux_todo/action/ActionToggleTodo.dart';
import 'package:redux_todo/dispatcher/Dispatcher.dart';
import 'package:redux_todo/resources/Colors.dart';
import 'package:redux_todo/resources/Strings.dart';
import 'package:redux_todo/resources/Styles.dart';
import 'package:redux_todo/screen/info/ScreenInfo.dart';
import 'package:redux_todo/screen/navigation/GlobalNavigator.dart';
import 'package:redux_todo/screen/uikit/StatelessToolbar.dart';
import 'package:redux_todo/store/StateProvider.dart';
import 'package:redux_todo/store/Store.dart';

class ScreenMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenMainState();
}

class ScreenMainState extends State {
  var _dispatcher = Dispatcher();
  var _stateProvider = StateProvider();
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dispatcher.dispatch(ActionInitTodos.initTodos());
  }

  @override
  Widget build(BuildContext context) {
    _setNavigatorContext(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StatelessToolbar(
              title: AppStrings.app_name,
              rightButtonIcon: Icons.info_outline,
              onRightIconPressedAction: () {GlobalNavigator().navigateTo(ScreenInfo());},
            ),
            StatelessTodoAddingWidget(
              textController: textController,
            ),
            Row(
              children: <Widget>[
                Spacer(),
                MaterialButton(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: AppColors.text,
                    child: Text("Add todo", style: AppStyles.text_style_default_light_bold,),
                  ),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      _dispatcher.dispatch(ActionAddTodo(textController.text));
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 32.0, left: 16.0),
              child: Text("Todos", textAlign: TextAlign.left, style: AppStyles.text_style_default_dark_bold,),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _stateProvider.getStateStream(),
                initialData: _stateProvider.getPreviousState(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var actualState = snapshot.data as StoreState;
                  return ListView.builder(
                    itemCount: actualState.todos.length,
                    itemBuilder: (context, index) {
                      return StatelessTodoItem(
                        title: actualState.todos[index].title,
                        isCompleted: actualState.todos[index].isCompleted,
                        onCheckIconPressedAction: () {
                          _dispatcher.dispatch(ActionToggleTodo(index));
                        },
                        onRemoveIconPressedAction: () {
                          _dispatcher.dispatch(ActionRemoveTodo(index));
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setNavigatorContext(BuildContext context) {
    GlobalNavigator().context = context;
  }

}

class StatelessTodoItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final void Function() onCheckIconPressedAction;
  final void Function() onRemoveIconPressedAction;

  const StatelessTodoItem(
    {
      Key key, 
      this.title, 
      this.isCompleted,
      this.onCheckIconPressedAction,
      this.onRemoveIconPressedAction
    }
  ) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 4.0,
        bottom: 4.0
      ),
      child: Wrap(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(title, style: AppStyles.text_style_default_dark,),
              Spacer(),
              _buildCompletedIconButton(),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onRemoveIconPressedAction,
              )
            ],
          ),
          Divider(
            height: 1.0,
            thickness: 2.0,
          )
        ],
      )
    );
  }

  Widget _buildCompletedIconButton() {
    if (isCompleted) {
      return IconButton(
        icon: Icon(Icons.check_box),
        onPressed: onCheckIconPressedAction,
      );
    } else {
      return IconButton(
        icon: Icon(Icons.check_box_outline_blank),
        onPressed: onCheckIconPressedAction
      );
    }
  }
}

class StatelessTodoAddingWidget extends StatelessWidget {
  final TextEditingController textController;

  const StatelessTodoAddingWidget({Key key, this.textController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: TextField(
        controller: textController,
        style: AppStyles.text_style_default,
      ),
    );
  }
}