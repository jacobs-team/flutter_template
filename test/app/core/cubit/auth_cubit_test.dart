import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  group(AuthCubit, () {
    const user = 'user';
    const token = 'token';
    late CoffeeBloc coffeeBloc;

    setUp(() {
      initHydratedStorage();
      coffeeBloc = MockCoffeeBloc();
    });

    blocTest<AuthCubit, AuthState>(
      'emits correct state when setSession is called',
      build: AuthCubit.new,
      act: (cubit) => cubit.setSession(user, token),
      expect: () => [const AuthState(user: user, token: token)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits empty state and adds $ClearFeed when logout is called',
      setUp: () async {
        if (GetIt.I.isRegistered<CoffeeBloc>()) {
          await GetIt.I.unregister<CoffeeBloc>();
        }
        GetIt.I.registerSingleton<CoffeeBloc>(coffeeBloc);
      },
      build: AuthCubit.new,
      seed: () => const AuthState(user: user, token: token),
      act: (cubit) => cubit.logout(),
      expect: () => [const AuthState()],
      verify: (_) {
        verify(() => coffeeBloc.add(const ClearFeed())).called(1);
      },
    );

    test('signedIn returns true when user and token are present', () {
      const state = AuthState(user: user, token: token);
      expect(state.signedIn, isTrue);
    });

    test('fromJson returns correct $AuthState', () {
      final json = <String, dynamic>{'user': user, 'token': token};
      expect(
        AuthCubit().fromJson(json),
        const AuthState(user: user, token: token),
      );
    });

    test(
      'addListener and removeListener manage listeners and notify on onChange',
      () {
        final cubit = AuthCubit();
        var called = 0;
        void listener() => called++;

        cubit
          ..addListener(listener)
          ..setSession(user, token);
        expect(called, 1);

        cubit
          ..removeListener(listener)
          ..setSession('new_user', 'new_token');
        expect(called, 1);
      },
    );
  });
}
