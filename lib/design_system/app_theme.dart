// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_template/design_system/app_design.dart';
import 'package:flutter_template/design_system/app_palette.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for defining the application's visual theme.
class AppTheme {
  /// Applies letter spacing as a percentage of the style's font size.
  static TextStyle? _spaced(TextStyle? style, double percent) =>
      style?.copyWith(letterSpacing: percent * (style.fontSize ?? 14));

  static TextTheme _buildTextTheme(TextTheme base) {
    final manrope = GoogleFonts.manropeTextTheme(base);
    return manrope.copyWith(
      displayLarge: _spaced(manrope.displayLarge, -0.02),
      displayMedium: _spaced(manrope.displayMedium, -0.02),
      displaySmall: _spaced(manrope.displaySmall, -0.02),
      labelLarge: _spaced(manrope.labelLarge, 0.05),
      labelMedium: _spaced(manrope.labelMedium, 0.05),
      labelSmall: _spaced(manrope.labelSmall, 0.05),
    );
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final base = ThemeData(colorScheme: colorScheme);
    final textTheme = _buildTextTheme(base.textTheme);

    final smRadius = BorderRadius.circular(AppDesign.radius.sm);
    final smShape = RoundedRectangleBorder(borderRadius: smRadius);
    final mdShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDesign.radius.md),
    );
    final lgShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDesign.radius.lg),
    );
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: AppDesign.spacing.xl,
      vertical: AppDesign.spacing.md,
    );
    final inputBorder = OutlineInputBorder(
      borderRadius: smRadius,
      borderSide: BorderSide.none,
    );

    return base.copyWith(
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        elevation: 0,
        shape: mdShape,
        margin: EdgeInsets.zero,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: mdShape,
          padding: buttonPadding,
          textStyle: textTheme.labelLarge,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          elevation: 0,
          shape: mdShape,
          padding: buttonPadding,
          textStyle: textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: mdShape,
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: mdShape,
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            color: colorScheme.surfaceTint.withValues(alpha: 0.3),
          ),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDesign.spacing.lg,
          vertical: AppDesign.spacing.md,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
        shape: const StadiumBorder(),
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(
          horizontal: AppDesign.spacing.md,
          vertical: AppDesign.spacing.xs,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.primaryContainer.withValues(alpha: 0.15),
        elevation: 0,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
            size: AppDesign.iconSizes.md,
          ),
        ),
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.primaryContainer.withValues(alpha: 0.15),
        elevation: 0,
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        elevation: 0,
        shape: lgShape,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDesign.radius.lg),
          ),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        shape: smShape,
        behavior: SnackBarBehavior.floating,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        shape: const CircleBorder(),
      ),

      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.2),
        thickness: 0.5,
        space: 0,
      ),

      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDesign.spacing.lg,
          vertical: AppDesign.spacing.xs,
        ),
        shape: smShape,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.onPrimary
              : colorScheme.onSurfaceVariant,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surfaceContainerHighest,
        circularTrackColor: colorScheme.surfaceContainerHighest,
      ),
    );
  }

  /// Light theme configuration.
  static final ThemeData light = _buildTheme(AppPalette.lightScheme);

  /// Dark theme configuration.
  static final ThemeData dark = _buildTheme(AppPalette.darkScheme);
}
