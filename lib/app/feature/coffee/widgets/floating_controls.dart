import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_template/app/widgets/widgets.dart';

/// {@template floating_controls}
/// A glassmorphic pill of floating controls for the coffee discovery feed.
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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        GlassContainer(
          padding: EdgeInsets.zero,
          child: IconButton(
            onPressed: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            ),
            icon: const Icon(Icons.arrow_upward),
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        GlassContainer(
          padding: EdgeInsets.zero,
          child: IconButton(
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            ),
            icon: const Icon(Icons.arrow_downward),
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        _FavoriteButton(colorScheme: colorScheme),
      ],
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
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

        return GlassContainer(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () =>
                getIt<CoffeeBloc>().add(ToggleFavoriteImage(imageUrl)),
            icon: savingImage
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    favorited ? Icons.favorite : Icons.favorite_outline,
                  ),
            color: favorited
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            style: favorited
                ? IconButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  )
                : null,
          ),
        );
      },
    );
  }
}
