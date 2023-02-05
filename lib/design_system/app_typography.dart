import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppTypography extends Equatable {
  final TextStyle headline1;
  final TextStyle headline2;
  final TextStyle numbers;
  final TextStyle button;

  const AppTypography({
    required this.headline1,
    required this.headline2,
    required this.numbers,
    required this.button,
  });

  static final defaultTypography = AppTypography(
    headline1: _defaultTextStyle(18),
    headline2: _defaultTextStyle(16),
    numbers: _defaultTextStyle(20),
    button: _defaultTextStyle(12),
  );

  static TextStyle _defaultTextStyle(double fontSize) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        height: 1.4,
        letterSpacing: 0,
        fontFamily: 'Poppins',
      );

  @override
  List<Object> get props => [
        headline1,
        headline2,
        numbers,
        button,
      ];
}
