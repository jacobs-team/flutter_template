import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  const coffeeImage = 'coffee_image';

  group(FavoriteImage, () {
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

    testWidgets('renders $FavoriteImage and shows image from cache', (
      tester,
    ) async {
      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, fileCacheService],
        const FavoriteImage(coffeeImage),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
      verify(() => fileCacheService.getFile(coffeeImage)).called(1);
    });

    testWidgets('triggers $ToggleFavoriteImage when remove icon is pressed', (
      tester,
    ) async {
      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, fileCacheService],
        const FavoriteImage(coffeeImage),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.remove_circle_outline));

      verify(
        () => coffeeBloc.add(const ToggleFavoriteImage(coffeeImage)),
      ).called(1);
    });

    testWidgets('opens dialog with $ExpandedImage when tapped', (tester) async {
      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, fileCacheService],
        const FavoriteImage(coffeeImage),
      );

      await tester.pumpAndSettle();
      final imageGesture = find
          .descendant(
            of: find.byType(FavoriteImage),
            matching: find.byType(GestureDetector),
          )
          .first;

      await tester.tap(imageGesture);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(ExpandedImage), findsOneWidget);
      expect(find.byType(Dismissible), findsOneWidget);
    });

    testWidgets('shows $CircularProgressIndicator while loading file', (
      tester,
    ) async {
      final completer = Completer<File>();
      when(
        () => fileCacheService.getFile(any()),
      ).thenAnswer((_) => completer.future);

      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, fileCacheService],
        const FavoriteImage(coffeeImage),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.complete(mockFile);
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
