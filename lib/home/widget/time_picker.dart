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
    final color = theme.color;
    final typography = theme.typography;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Set time",
            style: typography.headline1.copyWith(color: color.white),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "Hours",
                  style: typography.headline2.copyWith(color: color.gold),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Minutes",
                  style: typography.headline2.copyWith(color: color.gold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: color.darkGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _TimeSelector(
                    onChanged: _setSelectedHour,
                    maxValue: 23,
                    initialValue: currentHour,
                  ),
                ),
                Expanded(
                  child: _TimeSelector(
                    onChanged: _setSelectedMinute,
                    maxValue: 59,
                    initialValue: currentMinute,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: color.gold),
                    //Add border radius
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: Text(
                    "Cancel",
                    style: typography.button.copyWith(
                      color: color.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: selectedHour != 0 || selectedMinute != 0
                      ? _savePressed
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.gold,
                    disabledBackgroundColor: color.goldDisabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: Text(
                    "Save",
                    style: typography.button.copyWith(
                      color: color.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _savePressed() {
    widget.onTimeSelected(selectedHour, selectedMinute);
    Navigator.of(context).pop();
  }

  void _setSelectedHour(int hour) {
    setState(() => selectedHour = hour);
  }

  void _setSelectedMinute(int minute) {
    setState(() => selectedMinute = minute);
  }
}

class _TimeSelector extends StatefulWidget {
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
  State<_TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<_TimeSelector> {
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    final color = theme.color;
    return Stack(
      children: [
        ListWheelScrollView.useDelegate(
          physics: const FixedExtentScrollPhysics(),
          itemExtent: 40,
          diameterRatio: 100,
          onSelectedItemChanged: (value) {
            final currValue =
                (value + widget.initialValue) % (widget.maxValue + 1);
            setState(() => selectedValue = currValue);
            widget.onChanged(currValue);
          },
          childDelegate: ListWheelChildLoopingListDelegate(
            children: List.generate(
              widget.maxValue - widget.minValue + 1,
              (index) {
                final value = (index + widget.minValue + widget.initialValue) %
                    (widget.maxValue + 1);
                return Center(
                  child: Text(
                    '$value'.padLeft(2, '0'),
                    style: typography.numbers.copyWith(
                      color: value == selectedValue ? color.gold : color.beige,
                    ),
                  ),
                );
              },
              growable: false,
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: color.goldDimmed,
                  border: Border(
                    top: BorderSide(
                      color: color.gold,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: color.gold,
                      width: 1,
                    ),
                  ),
                ),
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
