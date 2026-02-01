import 'package:flutter/material.dart';

/// Central place for defining the application's visual theme.
///
/// Extend this file as the design system grows (colors, typography,
/// component themes, etc.).
class AppTheme {
  /// Dark theme configuration.
  static final ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
  );

  /// Light theme configuration.
  static final ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
  );
}
