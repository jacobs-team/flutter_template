import 'package:dio/dio.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  const path = 'path';

  group(RestClient, () {
    late Dio dio;
    late AuthCubit authCubit;
    late DevToolsCubit devToolsCubit;
    late RestClient restClient;
    late CancelToken cancelToken;

    setUp(() {
      initHydratedStorage();
      dio = MockDio();
      authCubit = MockAuthCubit();
      devToolsCubit = MockDevToolsCubit();
      cancelToken = CancelToken();

      when(() => authCubit.cancelToken).thenReturn(cancelToken);
      when(() => dio.interceptors).thenReturn(Interceptors());

      restClient = RestClient(authCubit, devToolsCubit, dio);
    });

    test('get calls dio.get with correct $path', () async {
      when(
        () => dio.get<dynamic>(
          any(),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions()));

      await restClient.get<dynamic>(path);

      verify(
        () => dio.get<dynamic>(
          path,
          options: any(named: 'options'),
          cancelToken: cancelToken,
        ),
      ).called(1);
    });

    test('creates its own $Dio when not passed in', () async {
      final client = RestClient(authCubit, devToolsCubit);
      expect(client, isA<RestClient>());
    });

    test('patch calls dio.patch with correct $path', () async {
      const body = {'key': 'value'};
      when(
        () => dio.patch<dynamic>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions()));

      await restClient.patch<dynamic>(path, body: body);

      verify(
        () => dio.patch<dynamic>(
          path,
          data: body,
          options: any(named: 'options'),
          cancelToken: cancelToken,
        ),
      ).called(1);
    });

    test('post calls dio.post with correct $path', () async {
      when(
        () => dio.post<dynamic>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions()));

      await restClient.post<dynamic>(path);

      verify(
        () => dio.post<dynamic>(
          path,
          options: any(named: 'options'),
          cancelToken: cancelToken,
        ),
      ).called(1);
    });

    test('put calls dio.put with correct $path', () async {
      when(
        () => dio.put<dynamic>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions()));

      await restClient.put<dynamic>(path);

      verify(
        () => dio.put<dynamic>(
          path,
          options: any(named: 'options'),
          cancelToken: cancelToken,
        ),
      ).called(1);
    });

    test('delete calls dio.delete with correct $path', () async {
      when(
        () => dio.delete<dynamic>(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions()));

      await restClient.delete<dynamic>(path);

      verify(
        () => dio.delete<dynamic>(
          path,
          options: any(named: 'options'),
          cancelToken: cancelToken,
        ),
      ).called(1);
    });

    test('close calls dio.close in $RestClient', () {
      when(() => dio.close()).thenAnswer((_) => {});
      restClient.close();
      verify(() => dio.close()).called(1);
    });
  });
}
