import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_template/app/navigation/navigation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

class MockConnectivityCubit extends MockCubit<bool>
    implements ConnectivityCubit {}

class MockDevToolsCubit extends MockCubit<DevToolsState>
    implements DevToolsCubit {}

class MockCoffeeBloc extends MockBloc<CoffeeEvent, CoffeeState>
    implements CoffeeBloc {}

class MockCoffeeApi extends Mock implements CoffeeApi {}

class MockRestClient extends Mock implements RestClient {}

class MockFileCacheService extends Mock implements FileCacheService {}

class MockAppRouter extends Mock implements AppRouter {}

extension PumpApp on WidgetTester {
  Future<void> pumpPumpPumpItUP(
    Widget widget, {
    List<Object> deps = const [],
    Map<String, String>? localizations,
  }) async {
    initHydratedStorage();
    final getIt = GetIt.instance;
    await getIt.reset();

    getIt
      ..registerSingleton<AuthCubit>(MockAuthCubit())
      ..registerSingleton<ConnectivityCubit>(MockConnectivityCubit())
      ..registerSingleton<DevToolsCubit>(MockDevToolsCubit())
      ..registerSingleton<CoffeeBloc>(MockCoffeeBloc())
      ..registerSingleton<CoffeeApi>(MockCoffeeApi())
      ..registerSingleton<RestClient>(MockRestClient())
      ..registerSingleton<FileCacheService>(MockFileCacheService())
      ..registerSingleton<AppRouter>(MockAppRouter());

    for (final instance in [...deps]) {
      await _registerOverride(instance);
    }

    await pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          _AppLocalizationsDelegate(localizations: localizations ?? {}),
        ],
        home: Scaffold(body: widget),
      ),
    );

    await pump();
  }

  Future<void> _registerOverride(Object instance) async {
    final getIt = GetIt.instance;

    if (instance is AuthCubit) {
      getIt
        ..unregister<AuthCubit>()
        ..registerSingleton<AuthCubit>(instance);
    } else if (instance is ConnectivityCubit) {
      getIt
        ..unregister<ConnectivityCubit>()
        ..registerSingleton<ConnectivityCubit>(instance);
    } else if (instance is DevToolsCubit) {
      getIt
        ..unregister<DevToolsCubit>()
        ..registerSingleton<DevToolsCubit>(instance);
    } else if (instance is CoffeeBloc) {
      getIt
        ..unregister<CoffeeBloc>()
        ..registerSingleton<CoffeeBloc>(instance);
    } else if (instance is CoffeeApi) {
      getIt
        ..unregister<CoffeeApi>()
        ..registerSingleton<CoffeeApi>(instance);
    } else if (instance is RestClient) {
      getIt
        ..unregister<RestClient>()
        ..registerSingleton<RestClient>(instance);
    } else if (instance is FileCacheService) {
      getIt
        ..unregister<FileCacheService>()
        ..registerSingleton<FileCacheService>(instance);
    }
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<dynamic> {
  const _AppLocalizationsDelegate({this.localizations = const {}});
  final Map<String, String> localizations;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<dynamic> load(Locale locale) => SynchronousFuture(localizations);

  @override
  bool shouldReload(covariant LocalizationsDelegate<dynamic> old) => false;
}
