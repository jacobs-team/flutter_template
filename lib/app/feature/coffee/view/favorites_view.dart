import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/feature/coffee/coffee.dart';

/// {@template favorites_view}
/// A stateless widget that displays a grid of favorited coffee images.
/// {@endtemplate}
class FavoritesView extends StatelessWidget {
  /// {@macro favorites_view}
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoffeeBloc, CoffeeState, List<String>>(
      bloc: getIt<CoffeeBloc>(),
      selector: (state) {
        return state.favorites;
      },
      builder: (context, savedImages) {
        if (savedImages.isEmpty) {
          return const Center(child: Text('No saved images'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: savedImages.length,
          itemBuilder: (context, index) {
            return SavedCoffeeImage(
              key: ValueKey(savedImages[index]),
              savedImages[index],
            );
          },
        );
      },
    );
  }
}
