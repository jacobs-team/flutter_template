import 'package:flutter/material.dart';
import 'package:flutter_template/app/navigation/app_router.dart';
import 'package:flutter_template/app/widgets/widgets.dart';
import 'package:flutter_template/l10n/l10n.dart';
import 'package:flutter_template/theme/app_theme.dart';

/// {@template coffee_app}
/// The root widget of the application.
///
/// This widget configures the [MaterialApp] with:
/// * Routing via [AppRouter].
/// * Theming via [AppTheme].
/// * Localization via [AppLocalizations].
/// * Responsive layout support via the [Layout] widget.
/// {@endtemplate}
class CoffeeApp extends StatelessWidget {
  /// {@macro coffee_app}
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => Layout(child: child!),
    );
  }
}
