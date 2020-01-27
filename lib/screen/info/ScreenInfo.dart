import 'package:flutter/material.dart';
import 'package:redux_todo/resources/Colors.dart';
import 'package:redux_todo/resources/Strings.dart';
import 'package:redux_todo/resources/Styles.dart';
import 'package:redux_todo/screen/navigation/GlobalNavigator.dart';
import 'package:redux_todo/screen/uikit/StatelessToolbar.dart';

class ScreenInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenInfoState();
}

class ScreenInfoState extends State {

  @override
  Widget build(BuildContext context) {
    _setNavigatorContext(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StatelessToolbar(
              title: AppStrings.screen_about_title,
              onBackPressedAction: () {GlobalNavigator().navigateBack();},
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                AppStrings.app_info,
                style: AppStyles.text_style_default_dark,
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