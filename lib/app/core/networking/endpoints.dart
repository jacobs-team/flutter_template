/// Centralized route definitions for all services.
///
/// Use namespaces for service groups:
/// * [AppEndpoints.coffee] for coffee services.
abstract final class AppEndpoints {
  /// Routes related to coffee services.
  static const coffee = CoffeeRoutes._();
}

/// Namespace for Coffee routes.
final class CoffeeRoutes {
  const CoffeeRoutes._();

  /// Path: /random.json
  String get random => '/random.json';
}
