// import 'package:dio/dio.dart';
// import 'package:flutter_template/app/core/networking/api/api.dart';
// import 'package:flutter_template/environment.dart';
// import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// @singleton
// class API {
//   API(this._client);
//   final RestClient _client;

//   Future<Response<dynamic>> getCoffeeImageUrl() async {
//     return _client.get(
//       AppEndpoints.coffee.random,
//       apiType: ApiType.public,
//     );
//   }
// }

// @singleton
// class RestClient {
//   RestClient()
//     : _dio = Dio(
//         BaseOptions(
//           baseUrl: 'https://${EnvironmentConfig.apiDomain}',
//         ),
//       )..interceptors.add(PrettyDioLogger());

//   final Dio _dio;

//   Future<Response<dynamic>> get(
//     String path, {
//     ApiType apiType = ApiType.protected,
//     Map<String, dynamic>? queryParameters,
//     Map<String, dynamic>? headers,
//     CancelToken? cancelToken,
//   }) async {
//     final requestOptions = _getOptions(apiType);
//     if (headers != null) {
//       requestOptions.headers?.addAll(headers);
//     }
//     return _dio.get(
//       path,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//   }

//   Options _getOptions(ApiType api) {
//     switch (api) {
//       case ApiType.public:
//         return PublicApiOptions();
//       case ApiType.protected:
//         const apiToken = '';
//         return ProtectedApiOptions(apiToken);
//     }
//   }
// }

// enum ApiType { public, protected }

// class PublicApiOptions extends Options {
//   PublicApiOptions() {
//     super.headers = <String, dynamic>{
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//     };
//   }
// }

// class ProtectedApiOptions extends Options {
//   ProtectedApiOptions(String apiToken) {
//     super.headers = <String, dynamic>{
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiToken',
//     };
//   }
// }

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_template/environment.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// {@template api_client}
/// A REST client for app services built on [Dio].
/// * **Logging:** Optional request/response logging via [PrettyDioLogger]
/// and `enableLogging`.
/// {@endtemplate}
@singleton
class RestClient {
  /// {@macro api_client}
  RestClient(this._authCubit, [@ignoreParam Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(baseUrl: EnvironmentConfig.apiDomain),
          ) {
    _dio.interceptors.addAll([
      // if (enableLogging)
      //   PrettyDioLogger(
      //     requestBody: true,
      //     maxWidth: 100,
      //   ),
      // if (enableAutoRetry)
      //   RetryInterceptor(
      //     dio: _dio,
      //     logPrint: log,
      //     retries: config.maxRetryAttempts,
      //     retryDelays: [
      //       const Duration(seconds: 1),
      //       const Duration(seconds: 3),
      //     ],
      //   ),
    ]);
  }

  final Dio _dio;

  final AuthCubit _authCubit;

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
