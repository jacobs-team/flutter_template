import 'package:dio/dio.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:injectable/injectable.dart';

/// {@template api}
/// A service class that acts as a high-level interface for network requests.
///
/// This class uses [RestClient] to communicate with the backend and leverages
/// [AppEndpoints] for centralized route management.
/// {@endtemplate}
@singleton
class API {
  /// {@macro api}
  API(this._client);

  /// The underlying client used to perform HTTP operations.
  final RestClient _client;

  /// Fetches a random coffee image URL.
  Future<Response<dynamic>> getCoffeeImageUrl() async {
    return _client.get(AppEndpoints.coffee.random);
  }
}
