import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:ddd_base_project/time_picker/widget/app_time_picker_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    final color = theme.color;

    const clearColor = Colors.transparent;

    return Scaffold(
      backgroundColor: color.beige,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                highlightColor: clearColor,
                splashColor: clearColor,
                onPressed: () {
                  _showTimePicker(
                    context: context,
                    barrierColor: color.backgroundBlur,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: color.gold,
                  child: Text(
                    "Show time picker",
                    style: typography.button.copyWith(color: color.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showTimePicker({
    required BuildContext context,
    required Color barrierColor,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierColor: barrierColor,
      builder: (BuildContext context) => const AppTimePickerDialog(),
    );
  }
}
