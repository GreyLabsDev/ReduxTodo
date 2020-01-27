import 'package:flutter/material.dart';

class GlobalNavigator {
  BuildContext context;

  GlobalNavigator._buildInstance();

  factory GlobalNavigator() => _navigatorInstance;
  static final _navigatorInstance = new GlobalNavigator._buildInstance();

  void navigateBack() {
    Navigator.pop(context);
  }

  void navigateTo(StatefulWidget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}