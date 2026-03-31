import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/navigation/navigation.dart';
import 'package:flutter_template/app/widgets/widgets.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.coffee_outlined),
            const SizedBox(width: 8),
            Text(
              destinations(context.l10n)[navigationShell.currentIndex].label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
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
      body: Stack(
        children: [
          Column(
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
                        onDestinationSelected: (index) =>
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
                                Icons.signal_cellular_nodata,
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
          if (!showRail)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: _FloatingNavBar(
                  destinations: destinations(context.l10n),
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (index) => navigationShell.goBranch(
                    index,
                    initialLocation: index == navigationShell.currentIndex,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GlassContainer(
      child: Row(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: destinations.indexed.map((entry) {
          final (i, d) = entry;
          final isSelected = i == selectedIndex;
          return IconButton(
            onPressed: () => onDestinationSelected(i),
            icon: isSelected ? d.selectedIcon ?? d.icon : d.icon,
            color: isSelected
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            style: isSelected
                ? IconButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }
}
