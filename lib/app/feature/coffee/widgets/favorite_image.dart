import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/feature/coffee/coffee.dart';
import 'package:go_router/go_router.dart';

/// {@template favorite_image}
/// A stateless widget that displays a single favorited coffee image from
/// the local cache.
///
/// It provides functionality to:
/// * Preview the image in an [ExpandedImage] dialog.
/// * Remove the image from favorites via [CoffeeBloc].
/// {@endtemplate}
class FavoriteImage extends StatelessWidget {
  /// {@macro favorite_image}
  const FavoriteImage(this.coffeeImage, {super.key});

  /// The unique URL identifier for the cached coffee image.
  final String coffeeImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder<File?>(
          future: getIt<FileCacheService>().getFile(coffeeImage),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done ||
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return GestureDetector(
              onTap: () {
                unawaited(
                  showDialog<void>(
                    context: context,
                    builder: (context) => Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                      direction: DismissDirection.vertical,
                      child: ExpandedImage(coffeeImage),
                    ),
                  ),
                );
              },
              child: Image.memory(
                snapshot.data!.readAsBytesSync(),
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
            ),
            onPressed: () =>
                getIt<CoffeeBloc>().add(ToggleFavoriteImage(coffeeImage)),
          ),
        ),
      ],
    );
  }
}
