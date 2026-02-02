import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/navigation/navigation.dart';
import 'package:flutter_template/app/widgets/layout.dart';
import 'package:flutter_template/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

/// {@template navigation_wrapper}
/// Route wrapper that dynamically switches between a [NavigationBar]
/// for mobile layouts and a [NavigationRail] for tablet and desktop layouts
/// based on [LayoutData].
/// {@endtemplate}
class NavigationWrapper extends StatelessWidget {
  /// {@macro navigation_wrapper}
  const NavigationWrapper({required this.navigationShell, super.key});

  /// The navigation shell managed by [GoRouter] that maintains the
  /// navigation stack.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final showRail = context.layout > LayoutData.small;
    final expandRail = context.layout > LayoutData.large;
    const destinations = AppRouter.destinations;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: getIt<AuthCubit>().logout,
            icon: const Icon(Icons.logout),
          ),
          if (kDebugMode)
            IconButton(
              onPressed: () => context.push(Routes.devTools),
              icon: const Icon(Icons.code),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (showRail)
                  NavigationRail(
                    extended: expandRail,
                    destinations: destinations(context.l10n)
                        .map(
                          (d) => NavigationRailDestination(
                            icon: d.icon,
                            label: Text(d.label),
                            selectedIcon: d.selectedIcon,
                          ),
                        )
                        .toList(),
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: (int index) =>
                        navigationShell.goBranch(
                          index,
                          initialLocation:
                              index == navigationShell.currentIndex,
                        ),
                  ),
                Expanded(
                  child: navigationShell,
                ),
              ],
            ),
          ),
          BlocSelector<ConnectivityCubit, bool, bool>(
            bloc: getIt<ConnectivityCubit>(),
            selector: (state) {
              return state;
            },
            builder: (context, connected) {
              return connected
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.signal_wifi_statusbar_connected_no_internet_4,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(context.l10n.noConnection),
                        ],
                      ),
                    );
            },
          ),
        ],
      ),
      bottomNavigationBar: !showRail
          ? NavigationBar(
              destinations: destinations(context.l10n),
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (int index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
            )
          : null,
    );
  }
}
