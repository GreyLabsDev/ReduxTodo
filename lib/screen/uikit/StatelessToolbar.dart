import 'package:flutter/material.dart';
import 'package:redux_todo/resources/Styles.dart';

class StatelessToolbar extends StatelessWidget {
  final void Function() onBackPressedAction;
  final void Function() onRightIconPressedAction;
  final String title;
  final IconData rightButtonIcon;

  const StatelessToolbar(
    {
      Key key, 
      this.onBackPressedAction, 
      this.onRightIconPressedAction, 
      this.title,
      this.rightButtonIcon
    }
  ) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Row(
      children: _buildToolbarWidgets(),
      ),
    );
  }

  List<Widget> _buildToolbarWidgets() {
    var widgets = <Widget>[];
    if (onBackPressedAction != null) {
      widgets.add(
        IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: onBackPressedAction,
          )
      );
    }
    widgets.addAll([
        SizedBox(width: 16.0,),
        Text(title, style: AppStyles.text_style_title,),
        Spacer()
      ]
    );
    if (onRightIconPressedAction != null && rightButtonIcon != null) {
      widgets.add(
        IconButton(
            icon: Icon(rightButtonIcon, color: Colors.black,),
            color: Colors.white,
            onPressed: onRightIconPressedAction,
          )
      );
    }
    return widgets;
  }
}