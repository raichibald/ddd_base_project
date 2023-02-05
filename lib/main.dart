import 'package:ddd_base_project/design_system/app_theme_data.dart';
import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:ddd_base_project/home/widget/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      appThemeData: AppThemeData.light(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
