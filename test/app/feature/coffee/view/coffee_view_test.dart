import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  const url = 'url';
  group(CoffeeView, () {
    late CoffeeBloc coffeeBloc;
    late ConnectivityCubit connectivityCubit;

    setUp(() {
      initHydratedStorage();
      coffeeBloc = MockCoffeeBloc();
      connectivityCubit = MockConnectivityCubit();

      when(() => coffeeBloc.state).thenReturn(const CoffeeState());
      when(() => coffeeBloc.stream).thenAnswer((_) => const Stream.empty());
      when(() => connectivityCubit.state).thenReturn(true);
      when(
        () => connectivityCubit.stream,
      ).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders $CoffeeView and loads initial images', (tester) async {
      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, connectivityCubit],
        const CoffeeView(),
      );

      expect(find.byType(CoffeeView), findsOneWidget);
      verify(() => coffeeBloc.add(const LoadImages(0))).called(1);
    });

    testWidgets('shows $SnackBar when loading fails in $CoffeeView', (
      tester,
    ) async {
      const errorMessage = 'error';
      whenListen(
        coffeeBloc,
        Stream.fromIterable([
          const CoffeeState(),
          const CoffeeState(
            loadingState: CoffeeLoadingState.failure,
            errorMessage: errorMessage,
          ),
        ]),
        initialState: const CoffeeState(),
      );

      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, connectivityCubit],
        const CoffeeView(),
      );
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('triggers $LoadImages on page change in $CoffeeView', (
      tester,
    ) async {
      when(() => coffeeBloc.state).thenReturn(
        const CoffeeState(images: ['url1', 'url2']),
      );

      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, connectivityCubit],
        const CoffeeView(),
      );

      await tester.drag(find.byType(PageView), const Offset(0, -500));
      await tester.pumpAndSettle();

      verify(() => coffeeBloc.add(const LoadImages(1))).called(1);
    });

    testWidgets('triggers $ToggleFavoriteImage when $CoffeeImage is tapped', (
      tester,
    ) async {
      when(() => coffeeBloc.state).thenReturn(
        const CoffeeState(images: [url]),
      );

      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, connectivityCubit],
        const CoffeeView(),
      );

      await tester.tap(find.byType(CoffeeImage));
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(find.byType(CoffeeImage));
      await tester.pumpAndSettle();

      verify(() => coffeeBloc.add(const ToggleFavoriteImage(url))).called(1);
    });

    testWidgets('triggers $LoadImages when $ConnectivityCubit reconnects', (
      tester,
    ) async {
      whenListen(
        connectivityCubit,
        Stream.fromIterable([false, true]),
        initialState: false,
      );

      await tester.pumpPumpPumpItUP(
        deps: [coffeeBloc, connectivityCubit],
        const CoffeeView(),
      );
      await tester.pump();

      verify(
        () => coffeeBloc.add(const LoadImages(0)),
      ).called(greaterThan(0));
    });
  });
}
