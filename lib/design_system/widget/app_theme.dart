import 'package:ddd_base_project/design_system/app_theme_data.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final AppThemeData appThemeData;

  const AppTheme({
    Key? key,
    required this.appThemeData,
    required Widget child,
  }) : super(key: key, child: child);

  static AppThemeData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    if (result == null) {
      throw 'No AppTheme found in context';
    }

    return result.appThemeData;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) =>
      appThemeData != oldWidget.appThemeData;
}
