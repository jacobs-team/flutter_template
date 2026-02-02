import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_template/environment.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'interceptors/logging_interceptor.dart';

/// {@template api_client}
/// A REST client for app services built on [Dio].
/// * **Logging:** Optional request/response logging via [PrettyDioLogger]
/// and [DevToolsCubit].
/// {@endtemplate}
@singleton
class RestClient {
  /// {@macro api_client}
  RestClient(this._authCubit, this._devToolsCubit, [@ignoreParam Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(baseUrl: EnvironmentConfig.apiDomain),
          ) {
    _dio.interceptors.addAll([
      if (kDebugMode)
        LoggingInterceptor(
          _devToolsCubit,
          PrettyDioLogger(
            requestBody: true,
            maxWidth: 100,
          ),
        ),
    ]);
  }

  final Dio _dio;

  final AuthCubit _authCubit;

  final DevToolsCubit _devToolsCubit;

  /// Closes the underlying Dio client.
  void close() => _dio.close();

  /// Sends a GET request to the specified [path].
  Future<Response<T>> get<T>(
    String path, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    return _dio.get<T>(
      path,
      options: Options(headers: headers),
      cancelToken: cancelToken ?? _authCubit.cancelToken,
    );
  }

  /// Sends a PATCH request to the specified [path].
  Future<Response<T>> patch<T>(
    String path, {
    Map<String, String>? headers,
    Object? body,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    return _dio.patch<T>(
      path,
      options: Options(headers: headers),
      data: body,
      cancelToken: cancelToken ?? _authCubit.cancelToken,
    );
  }

  /// Sends a POST request to the specified [path].
  Future<Response<T>> post<T>(
    String path, {
    Map<String, String>? headers,
    Object? body,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    return _dio.post<T>(
      path,
      options: Options(headers: headers),
      data: body,
      cancelToken: cancelToken ?? _authCubit.cancelToken,
    );
  }

  /// Sends a PUT request to the specified [path].
  Future<Response<T>> put<T>(
    String path, {
    Map<String, String>? headers,
    Object? body,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    return _dio.put<T>(
      path,
      options: Options(headers: headers),
      data: body,
      cancelToken: cancelToken ?? _authCubit.cancelToken,
    );
  }

  /// Sends a DELETE request to the specified [path].
  Future<Response<T>> delete<T>(
    String path, {
    Map<String, String>? headers,
    Object? body,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    return _dio.delete<T>(
      path,
      options: Options(headers: headers),
      data: body,
      cancelToken: cancelToken ?? _authCubit.cancelToken,
    );
  }
}
