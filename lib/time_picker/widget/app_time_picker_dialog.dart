import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTimePickerDialog extends StatefulWidget {
  const AppTimePickerDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AppTimePickerDialog> createState() => _AppTimePickerDialogState();
}

class _AppTimePickerDialogState extends State<AppTimePickerDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final color = theme.color;
    final typography = theme.typography;

    return Container(
      height: 288,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: color.beige,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  pickerTextStyle: typography.numbers.copyWith(
                    color: color.darkGrey,
                  ),
                ),
              ),
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (Duration newDuration) {
                  // TODO: Handle time change
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  // TODO: Make it a design system widget with a ripple
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    color: color.gold,
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: typography.button.copyWith(
                          color: color.white,
                          decorationColor: Colors.transparent,
                          decorationThickness: 0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
