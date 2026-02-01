import 'package:flutter_template/app/core/core.dart';
import 'package:injectable/injectable.dart';

/// {@template coffee_repository}
/// A repository that handles data operations for coffee-related resources.
///
/// {@endtemplate}
@lazySingleton
class CoffeeRepository {
  /// {@macro coffee_repository}
  CoffeeRepository(this._api);

  /// The underlying API service used to fetch data.
  final API _api;

  /// Fetches a random coffee image.
  Future<CoffeeImage> getCoffeeImage() async {
    final response = await _api.getCoffeeImageUrl();
    return mapJson(response.data, CoffeeImage.fromJson);
  }
}
