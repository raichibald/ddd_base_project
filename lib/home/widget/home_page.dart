import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:ddd_base_project/home/widget/time_picker.dart';
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
                onPressed: () => _openTimePicker(context),
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

  Future<void> _openTimePicker(BuildContext context) async {
    final theme = AppTheme.of(context);
    final color = theme.color;
    final typography = theme.typography;

    await showModalBottomSheet(
      context: context,
      backgroundColor: color.darkGrey.withOpacity(0.65),
      useSafeArea: true,
      builder: (BuildContext context) => TimePicker(
        onTimeSelected: (int hour, int minute) {
          print("Hour: $hour");
          print("Minute: $minute");
        },
      ),
    );
  }
}
