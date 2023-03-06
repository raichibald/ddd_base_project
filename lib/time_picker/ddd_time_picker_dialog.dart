import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Known issues, would probably need around ~30 more min to polish it off
// 1. Overscroll behaviour (cut off padding at the top)
// 2. Bottom safe area is h/c
// 3. Numbers not perfectly centered
// 4. Center item is not tappable
// 5. Some small UI hacks that don't impact performance, but are still hacky
// 6. Code is not clean
// 7. Haptic feedback is in code, but doesn't work on devices I tested
// 8. Should use normal buttons instead of containers

class DDDTimePickerDialog extends StatefulWidget {
  const DDDTimePickerDialog({Key? key}) : super(key: key);

  @override
  State<DDDTimePickerDialog> createState() => _DDDTimePickerDialogState();
}

class _DDDTimePickerDialogState extends State<DDDTimePickerDialog> {
  var _isValidTime = false;
  var _selectedHour = 0;
  var _selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    const dummySafeArea = 24.0;
    final selectorWidth = MediaQuery.of(context).size.width - 24 * 2;
    final theme = AppTheme.of(context);
    final colors = theme.color;
    return Container(
      height: 330 + dummySafeArea,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        color: colors.darkGrey.withOpacity(0.65),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 4,
            width: 64,
            decoration: BoxDecoration(
              color: colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Set time",
            style: theme.typography.headline1.copyWith(color: colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Row(
              children: [
                Text(
                  'Hours',
                  style: theme.typography.headline2.copyWith(
                    color: colors.gold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Minutes',
                  style: theme.typography.headline2.copyWith(
                    color: colors.gold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors.darkGrey,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 12,
                  right: 12,
                  child: SizedBox(
                    height: 120,
                    width: selectorWidth - 24,
                    child: Row(
                      children: [
                        Expanded(
                          child: _TimeUnitScrollView(
                            onSelectedItemChanged: (item) {
                              HapticFeedback.lightImpact();
                              setState(() {
                                _selectedHour = item;
                                _isValidTime = !(_selectedHour == 0 &&
                                    _selectedMinute == 0);
                              });
                            },
                            maxValue: 24,
                            selectedValue: _selectedHour,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: _TimeUnitScrollView(
                            onSelectedItemChanged: (item) {
                              HapticFeedback.lightImpact();
                              setState(() {
                                _selectedMinute = item;
                                _isValidTime = !(_selectedHour == 0 &&
                                    _selectedMinute == 0);
                              });
                            },
                            maxValue: 60,
                            selectedValue: _selectedMinute,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 53,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    width: selectorWidth,
                    decoration: BoxDecoration(
                      color: colors.goldDimmed.withOpacity(0.2),
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: colors.gold,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.gold, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          'CANCEL',
                          style: theme.typography.button.copyWith(
                            color: colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_isValidTime) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: _isValidTime
                            ? colors.gold
                            : colors.goldDisabled.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: _isValidTime
                                ? colors.gold
                                : colors.goldDisabled.withOpacity(0.1),
                            width: 1),
                      ),
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: theme.typography.button.copyWith(
                            color: colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

class _TimeUnitScrollView extends StatelessWidget {
  final Function(int) onSelectedItemChanged;
  final int selectedValue;
  final int maxValue;

  const _TimeUnitScrollView({
    Key? key,
    required this.onSelectedItemChanged,
    required this.selectedValue,
    required this.maxValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.color;
    final typography = theme.typography;

    return ListWheelScrollView.useDelegate(
      perspective: 0.0000000001,
      itemExtent: 40,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildLoopingListDelegate(
        children: [
          for (var i = 0; i < maxValue; i++)
            Text(
              (i).toString(),
              style: typography.numbers.copyWith(
                color: i == selectedValue ? colors.gold : colors.beige,
              ),
            ),
        ],
      ),
    );
  }
}
