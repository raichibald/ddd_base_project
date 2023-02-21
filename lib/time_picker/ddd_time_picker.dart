import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DDDTimePicker extends StatefulWidget {
  final DateTime? initialTime;

  const DDDTimePicker({
    Key? key,
    this.initialTime,
  }) : super(key: key);

  @override
  State<DDDTimePicker> createState() => _DDDTimePickerState();
}

class _DDDTimePickerState extends State<DDDTimePicker> {
  late DateTime _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ??
        DateTime.now().copyWith(
          hour: 12,
          minute: 00,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    final color = theme.color;
    return Container(
        height: 350,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.beige,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: Brightness.light,
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                      typography.numbers,
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    initialDateTime: _selectedTime,
                    onDateTimeChanged: _setTime,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            elevation: 0,
                            height: 44,
                            color: color.gold,
                            onPressed: _popWithSelection,
                            child: Text(
                              'Select',
                              style: typography.button.copyWith(
                                color: color.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  _setTime(DateTime time) {
    setState(() {
      _selectedTime = time;
    });
  }

  _popWithSelection() {
    Navigator.of(context).pop(_selectedTime);
  }
}
