import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppColor extends Equatable {
  final Color beige;
  final Color gold;
  final Color white;
  final Color grey;
  final Color darkGrey;

  const AppColor({
    required this.beige,
    required this.gold,
    required this.white,
    required this.grey,
    required this.darkGrey,
  });

  factory AppColor.light() => const AppColor(
        beige: Color(0xFFE1D5C9),
        gold: Color(0xFFC39550),
        white: Color(0xFFFFFFFF),
        grey: Color(0xFFC4C4C4),
        darkGrey: Color(0xFF212325),
      );

  @override
  List<Object?> get props => [
        beige,
        gold,
        white,
        grey,
        darkGrey,
      ];
}
