import 'package:flutter/material.dart';

/// Central place for defining the application's visual theme.
///
/// Extend this file as the design system grows (colors, typography,
/// component themes, etc.).
class AppTheme {
  static final ThemeData _lightBase = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
  );

  /// Light theme configuration.
  static final ThemeData light = _lightBase.copyWith(
    appBarTheme: _lightBase.appBarTheme.copyWith(
      backgroundColor: _lightBase.colorScheme.surfaceContainer,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: _lightBase.navigationBarTheme.copyWith(
      backgroundColor: _lightBase.colorScheme.surfaceContainer,
    ),
    navigationRailTheme: _lightBase.navigationRailTheme.copyWith(
      backgroundColor: _lightBase.colorScheme.surfaceContainer,
    ),
  );

  static final ThemeData _darkBase = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.brown,
      brightness: Brightness.dark,
    ),
  );

  /// Dark theme configuration.
  static final ThemeData dark = _darkBase.copyWith(
    appBarTheme: _darkBase.appBarTheme.copyWith(
      backgroundColor: _darkBase.colorScheme.surfaceContainer,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: _darkBase.navigationBarTheme.copyWith(
      backgroundColor: _darkBase.colorScheme.surfaceContainer,
    ),
    navigationRailTheme: _darkBase.navigationRailTheme.copyWith(
      backgroundColor: _darkBase.colorScheme.surfaceContainer,
    ),
  );
}
