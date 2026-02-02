import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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

class MockDio extends Mock implements Dio {}

class MockPrettyDioLogger extends Mock implements PrettyDioLogger {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockFile extends Mock implements File {}

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
      ..registerSingleton<CoffeeRepository>(MockCoffeeRepository());

    for (final instance in [...deps]) {
      await _registerOverride(instance);
    }

    await pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          _AppLocalizationsDelegate(localizations: localizations ?? {}),
        ],
        home: Layout(child: Scaffold(body: widget)),
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
    } else if (instance is CoffeeRepository) {
      getIt
        ..unregister<CoffeeRepository>()
        ..registerSingleton<CoffeeRepository>(instance);
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

final transparentPixel = Uint8List.fromList([
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);
