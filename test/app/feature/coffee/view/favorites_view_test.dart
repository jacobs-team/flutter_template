import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  const url = 'url';

  group(FavoritesView, () {
    late CoffeeBloc coffeeBloc;
    late FileCacheService fileCacheService;
    late File mockFile;

    setUp(() {
      initHydratedStorage();
      coffeeBloc = MockCoffeeBloc();
      fileCacheService = MockFileCacheService();
      mockFile = MockFile();

      when(() => coffeeBloc.state).thenReturn(const CoffeeState());
      when(() => coffeeBloc.stream).thenAnswer((_) => const Stream.empty());

      when(() => mockFile.path).thenReturn('/temp');
      when(() => mockFile.readAsBytesSync()).thenReturn(transparentPixel);

      when(() => fileCacheService.getFile(any())).thenAnswer(
        (_) async => mockFile,
      );
    });

    testWidgets(
      'renders empty state message when favorites is empty in $FavoritesView',
      (tester) async {
        await tester.pumpPumpPumpItUP(
          deps: [coffeeBloc, fileCacheService],
          const FavoritesView(),
        );

        expect(find.text('No saved images'), findsOneWidget);
      },
    );

    testWidgets(
      'renders grid of $FavoriteImage when favorites exist '
      'in $FavoritesView',
      (tester) async {
        when(() => coffeeBloc.state).thenReturn(
          const CoffeeState(favorites: [url]),
        );

        await tester.pumpPumpPumpItUP(
          deps: [coffeeBloc, fileCacheService],
          const FavoritesView(),
        );

        expect(find.byType(GridView), findsOneWidget);
        expect(find.byType(FavoriteImage), findsOneWidget);
      },
    );
  });
}
