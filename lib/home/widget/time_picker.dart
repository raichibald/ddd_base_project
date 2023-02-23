import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final void Function(int, int) onTimeSelected;
  const TimePicker({
    super.key,
    required this.onTimeSelected,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  int selectedMinute = 0;
  int selectedHour = 0;
  late final int currentMinute;
  late final int currentHour;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMinute = now.minute;
    currentHour = now.hour;
    selectedMinute = currentMinute;
    selectedHour = currentHour;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TimeSelector(
              onChanged: _setSelectedHour,
              maxValue: 23,
              initialValue: currentHour,
            ),
            Text(
              ":",
              style: typography.numbers,
            ),
            _TimeSelector(
              onChanged: _setSelectedMinute,
              maxValue: 59,
              initialValue: currentMinute,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              widget.onTimeSelected(selectedHour, selectedMinute);
              Navigator.of(context).pop();
            },
            child: Text("Ok", style: typography.button),
          ),
        ),
      ],
    );
  }

  void _setSelectedHour(int hour) {
    setState(() => selectedHour = hour);
  }

  void _setSelectedMinute(int minute) {
    setState(() => selectedMinute = minute);
  }
}

class _TimeSelector extends StatelessWidget {
  final void Function(int) onChanged;
  final int minValue;
  final int maxValue;
  final int initialValue;

  const _TimeSelector({
    required this.onChanged,
    this.minValue = 0,
    required this.maxValue,
    this.initialValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    final color = theme.color;
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: 50,
          child: ListWheelScrollView.useDelegate(
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 50,
            diameterRatio: 1.5,
            onSelectedItemChanged: (value) {
              final selectedValue = (value + initialValue) % (maxValue + 1);
              onChanged(selectedValue);
            },
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List.generate(
                maxValue - minValue + 1,
                (index) {
                  final value =
                      (index + minValue + initialValue) % (maxValue + 1);
                  return Center(
                    child: Text(
                      '$value'.padLeft(2, '0'),
                      style: typography.numbers,
                    ),
                  );
                },
                growable: false,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: color.grey,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: color.grey,
                      width: 1,
                    ),
                  ),
                ),
                height: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
