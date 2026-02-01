import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/bloc/auth_cubit.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/feature/coffee/view/coffee_view.dart';
import 'package:flutter_template/app/feature/coffee/view/favorites_view.dart';
import 'package:flutter_template/app/navigation/navigation_wrapper.dart';
import 'package:flutter_template/app/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// {@template app_router}
/// Central navigation configuration using [GoRouter].
///
/// Defines the application's routing structure, including [StatefulShellRoute]
/// for bottom and rail navigation, route guards via redirect, and UI
/// destinations.
/// {@endtemplate}
@singleton
class AppRouter {
  /// The list of top-level routes and nested shell branches.
  static final routes = [
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
              routes: [
                GoRoute(
                  path: Routes.detail,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const NoTransitionPage(
                      child: Scaffold(),
                    );
                  },
                ),
              ],
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
    redirect: (context, state) {
      final isSigningIn = state.uri.path.startsWith(Routes.signIn);

      if (isSigningIn && getIt<AuthCubit>().state.signedIn) {
        return Routes.coffee;
      }

      return null;
    },
    routes: routes,
  );
}
