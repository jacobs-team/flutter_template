import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/core/dependencies/dependencies.dart';
import 'package:flutter_template/app/feature/coffee/bloc/coffee_bloc.dart';

/// {@template expanded_image}
/// A view that displays a full-screen, interactive gallery of favorited images.
///
/// It uses a [PageView] to navigate through the user's favorites, retrieving
/// cached files via [FileCacheService] and enabling zoom/pan through [InteractiveViewer].
/// {@endtemplate}
class ExpandedImage extends StatelessWidget {
  /// {@macro expanded_image}
  const ExpandedImage(this.initialImage, {super.key});

  /// The URL of the image that should be displayed first when the view opens.
  final String initialImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocSelector<CoffeeBloc, CoffeeState, List<String>>(
        bloc: getIt<CoffeeBloc>(),
        selector: (state) {
          return state.favorites;
        },
        builder: (context, favorites) {
          return PageView.builder(
            controller: PageController(
              initialPage: favorites.indexOf(initialImage),
            ),
            itemCount: favorites.length,
            itemBuilder: (context, pageIndex) {
              return FutureBuilder<File?>(
                future: getIt<FileCacheService>().getFile(
                  favorites[pageIndex],
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return InteractiveViewer(
                    child: Image.memory(
                      snapshot.data!.readAsBytesSync(),
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
