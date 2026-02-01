/// Centralized route definitions for all services.
///
/// Use namespaces for service groups:
/// * [Endpoints.coffee] for coffee services.
abstract final class Endpoints {
  /// Routes related to coffee services.
  static const coffee = CoffeeRoutes._();
}

/// Namespace for Coffee routes.
final class CoffeeRoutes {
  const CoffeeRoutes._();

  /// Path: /random.json
  String get random => '/random.json';
}
