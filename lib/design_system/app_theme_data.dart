import 'package:ddd_base_project/design_system/app_color.dart';
import 'package:ddd_base_project/design_system/app_typography.dart';
import 'package:equatable/equatable.dart';

class AppThemeData extends Equatable {
  final AppColor color;
  final AppTypography typography;

  const AppThemeData({
    required this.color,
    required this.typography,
  });

  factory AppThemeData.light() => AppThemeData(
        color: AppColor.light(),
        typography: AppTypography.defaultTypography,
      );

  @override
  List<Object> get props => [color, typography];
}
