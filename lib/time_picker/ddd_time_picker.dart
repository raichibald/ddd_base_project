import 'package:ddd_base_project/design_system/widget/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DDDTimePicker extends StatefulWidget {
  final int? initialHours;
  final int? initialMinutes;

  const DDDTimePicker({
    Key? key,
    this.initialHours,
    this.initialMinutes,
  }) : super(key: key);

  @override
  State<DDDTimePicker> createState() => _DDDTimePickerState();
}

class _DDDTimePickerState extends State<DDDTimePicker> {
  late int _selectedHours;
  late int _selectedMinutes;

  @override
  void initState() {
    super.initState();
    _selectedHours = widget.initialHours ?? 0;
    _selectedMinutes = widget.initialMinutes ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final typography = theme.typography;
    final color = theme.color;

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 64) / 2;
    return Container(
        height: 390,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.darkGrey.withOpacity(0.65),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 4,
                  width: 64,
                  decoration: BoxDecoration(
                    color: color.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Set time',
                style: typography.headline1.copyWith(
                  color: color.white,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Hours',
                        style: typography.headline2.copyWith(color: color.gold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: itemWidth,
                            height: 150,
                            decoration: BoxDecoration(
                              color: color.darkGrey,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                            ),
                          ),
                          NumberPicker(
                            minValue: 0,
                            maxValue: 23,
                            itemWidth: itemWidth,
                            value: _selectedHours,
                            onChanged: _setHours,
                            haptics: true,
                            infiniteLoop: true,
                            decoration: BoxDecoration(
                              color: color.goldDimmed,
                              border: Border(
                                top: BorderSide(color: color.gold, width: 1),
                                bottom: BorderSide(color: color.gold, width: 1),
                              ),
                            ),
                            textStyle:
                                typography.numbers.copyWith(color: color.beige),
                            selectedTextStyle:
                                typography.numbers.copyWith(color: color.gold),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Minutes',
                        style: typography.headline2.copyWith(color: color.gold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: itemWidth,
                            height: 150,
                            decoration: BoxDecoration(
                              color: color.darkGrey,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                          ),
                          NumberPicker(
                            minValue: 0,
                            maxValue: 59,
                            itemWidth: itemWidth,
                            value: _selectedMinutes,
                            onChanged: _setMinutes,
                            haptics: true,
                            infiniteLoop: true,
                            decoration: BoxDecoration(
                              color: color.goldDimmed,
                              border: Border(
                                top: BorderSide(color: color.gold, width: 1),
                                bottom: BorderSide(color: color.gold, width: 1),
                              ),
                            ),
                            textStyle:
                                typography.numbers.copyWith(color: color.beige),
                            selectedTextStyle:
                                typography.numbers.copyWith(color: color.gold),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            elevation: 0,
                            height: 48,
                            color: color.darkGrey.withOpacity(0.65),
                            onPressed: _popWithSelection,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: color.gold,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'CANCEL',
                              style: typography.button.copyWith(
                                color: color.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: MaterialButton(
                            elevation: 0,
                            height: 48,
                            color: color.gold,
                            disabledColor: color.goldDisabled,
                            onPressed:
                                (_selectedMinutes == 0 && _selectedHours == 0)
                                    ? null
                                    : _popWithSelection,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'SAVE',
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

  _setHours(int hours) {
    setState(() {
      _selectedHours = hours;
    });
  }

  _setMinutes(int minutes) {
    setState(() {
      _selectedMinutes = minutes;
    });
  }

  _popWithSelection() {
    Navigator.of(context).pop();
  }
}
