// coverage:ignore-file
// ignore_for_file: public_member_api_docs

import 'package:freezed_annotation/freezed_annotation.dart';
part 'coffee_image.freezed.dart';
part 'coffee_image.g.dart';

/// {@template coffee_image}
/// A data model with an image url.
/// {@endtemplate}
@freezed
abstract class CoffeeImage with _$CoffeeImage {
  /// {@macro coffee_image}
  const factory CoffeeImage({
    /// The file path or URL string for the coffee image.
    @JsonKey(name: 'file') required String imageUrl,
  }) = _CoffeeImage;

  factory CoffeeImage.fromJson(Map<String, dynamic> json) =>
      _$CoffeeImageFromJson(json);
}
