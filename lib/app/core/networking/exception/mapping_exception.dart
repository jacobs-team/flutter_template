// coverage:ignore-file

import 'package:flutter_template/app/core/core.dart';

/// {@template mapping_exception}
/// Exception thrown when an error occurs during data transformation or
/// JSON mapping.
///
/// This typically occurs when a model's `fromJson` factory encounters
/// unexpected data types or missing required fields.
/// {@endtemplate}
class MappingException extends AppException {
  /// {@macro mapping_exception}
  const MappingException(this.error, [this.stackTrace])
    : super('Data mapping error: $error');

  /// The underlying error that caused the mapping to fail.
  final Object error;

  /// The stack trace associated with the mapping failure.
  final StackTrace? stackTrace;

  @override
  String toString() =>
      '${super.toString()}${stackTrace != null ? '\n$stackTrace' : ''}';
}
