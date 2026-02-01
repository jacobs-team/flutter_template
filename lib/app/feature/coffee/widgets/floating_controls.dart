import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/feature/feature.dart';

/// {@template floating_controls}
/// A column of floating action buttons used to control the
/// coffee discovery feed.
/// {@endtemplate}
class FloatingControls extends StatelessWidget {
  /// {@macro floating_controls}
  const FloatingControls({
    required PageController pageController,
    super.key,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: 'btn_up',
          shape: const CircleBorder(),
          onPressed: () => _pageController.previousPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          ),
          child: const Icon(Icons.arrow_upward),
        ),
        const SizedBox(height: 6),
        FloatingActionButton.small(
          heroTag: 'btn_down',
          shape: const CircleBorder(),
          onPressed: () => _pageController.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          ),
          child: const Icon(Icons.arrow_downward),
        ),
        const SizedBox(height: 10),
        BlocSelector<
          CoffeeBloc,
          CoffeeState,
          (int, List<String>, List<String>, bool)
        >(
          bloc: getIt<CoffeeBloc>(),
          selector: (state) => (
            state.currentImage,
            state.images,
            state.favorites,
            state.loadingState == CoffeeLoadingState.saving,
          ),
          builder: (context, record) {
            final (currentImage, images, favorites, savingImage) = record;

            if (images.isEmpty || currentImage >= images.length) {
              return const SizedBox.shrink();
            }

            final imageUrl = images[currentImage];
            final favorited = favorites.contains(imageUrl);

            return FloatingActionButton(
              heroTag: 'btn_favorite',
              shape: const CircleBorder(),
              onPressed: () =>
                  getIt<CoffeeBloc>().add(ToggleFavoriteImage(imageUrl)),
              child: savingImage
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : Icon(favorited ? Icons.favorite : Icons.favorite_outline),
            );
          },
        ),
      ],
    );
  }
}
