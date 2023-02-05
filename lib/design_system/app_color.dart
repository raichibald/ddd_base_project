import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppColor extends Equatable {
  final Color beige;
  final Color gold;
  final Color goldDimmed;
  final Color goldDisabled;
  final Color white;
  final Color grey;
  final Color darkGrey;
  final Color backgroundBlur;

  const AppColor({
    required this.beige,
    required this.gold,
    required this.goldDimmed,
    required this.goldDisabled,
    required this.white,
    required this.grey,
    required this.darkGrey,
    required this.backgroundBlur,
  });

  factory AppColor.light() => AppColor(
        beige: const Color(0xFFE1D5C9),
        gold: const Color(0xFFC39550),
        goldDimmed: const Color(0xFFC39550).withOpacity(0.2),
        goldDisabled: const Color(0xFFC1A780),
        white: const Color(0xFFFFFFFF),
        grey: const Color(0xFFC4C4C4),
        darkGrey: const Color(0xFF212325),
        backgroundBlur: const Color(0xFF212325).withOpacity(0.45),
      );

  @override
  List<Object?> get props => [
        beige,
        gold,
        goldDimmed,
        goldDisabled,
        white,
        grey,
        darkGrey,
        backgroundBlur,
      ];
}
