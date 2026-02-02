// coverage:ignore-file

/// {@template app_exception}
/// Base class for all custom exceptions thrown by the application.
///
/// By extending [Exception], this class provides a consistent interface
/// for error handling and ensures that all app-specific errors
/// contain a human-readable [message].
/// {@endtemplate}
abstract class AppException implements Exception {
  /// {@macro app_exception}
  const AppException(this.message);

  /// A descriptive message explaining the cause of the exception.
  final String message;

  @override
  String toString() => message;
}
