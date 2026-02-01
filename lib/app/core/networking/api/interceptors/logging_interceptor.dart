part of '../rest_client.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor(this._devToolsCubit, this._logger);

  final DevToolsCubit _devToolsCubit;
  final PrettyDioLogger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_devToolsCubit.state.isApiDebug) {
      _logger.onRequest(options, handler);
    } else {
      super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (_devToolsCubit.state.isApiDebug) {
      _logger.onResponse(response, handler);
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_devToolsCubit.state.isApiDebug) {
      _logger.onError(err, handler);
    } else {
      super.onError(err, handler);
    }
  }
}
