// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/cubit/auth_cubit.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_template/app/navigation/navigation_wrapper.dart';
import 'package:flutter_template/app/navigation/routes.dart';
import 'package:go_router/go_router.dart';

/// {@template app_router}
/// Central navigation configuration using [GoRouter].
///
/// Defines the application's routing structure, including [StatefulShellRoute]
/// for bottom and rail navigation, route guards via redirect, and UI
/// destinations.
/// {@endtemplate}
class AppRouter {
  /// The list of top-level and nested Routes.
  static final List<RouteBase> routes = [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.coffee,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(
                  child: CoffeeView(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.favorites,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: FavoritesView());
              },
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) =>
          NavigationWrapper(navigationShell: navigationShell),
    ),
    GoRoute(
      path: Routes.signIn,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: SignInView());
      },
    ),
    if (kDebugMode)
      GoRoute(
        path: Routes.devTools,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: DevToolsView());
        },
      ),
  ];

  /// Data for rendering navigation bars or rails.
  static const destinations = [
    NavigationDestination(
      icon: Icon(Icons.coffee_outlined),
      selectedIcon: Icon(Icons.coffee),
      label: 'Coffee',
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_outline),
      selectedIcon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
  ];

  /// The global [GoRouter] instance used by the application.
  static GoRouter router = GoRouter(
    initialLocation: Routes.coffee,
    refreshListenable: getIt<AuthCubit>(),
    redirect: (context, state) {
      final signedIn = getIt<AuthCubit>().state.signedIn;
      final isSigningIn = state.uri.path.startsWith(Routes.signIn);

      // If not signedIn and trying to access a protected route - Force signIn.
      if (!signedIn && !isSigningIn) {
        return Routes.signIn;
      }

      // If signedIn and trying to access signIn -> Force coffee.
      if (signedIn && isSigningIn) {
        return Routes.coffee;
      }

      return null;
    },
    routes: routes,
  );
}
