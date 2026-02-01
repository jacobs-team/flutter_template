// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coffee_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoffeeImage {

/// The file path or URL string for the coffee image.
@JsonKey(name: 'file') String get imageUrl;
/// Create a copy of CoffeeImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoffeeImageCopyWith<CoffeeImage> get copyWith => _$CoffeeImageCopyWithImpl<CoffeeImage>(this as CoffeeImage, _$identity);

  /// Serializes this CoffeeImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeeImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl);

@override
String toString() {
  return 'CoffeeImage(imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $CoffeeImageCopyWith<$Res>  {
  factory $CoffeeImageCopyWith(CoffeeImage value, $Res Function(CoffeeImage) _then) = _$CoffeeImageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'file') String imageUrl
});




}
/// @nodoc
class _$CoffeeImageCopyWithImpl<$Res>
    implements $CoffeeImageCopyWith<$Res> {
  _$CoffeeImageCopyWithImpl(this._self, this._then);

  final CoffeeImage _self;
  final $Res Function(CoffeeImage) _then;

/// Create a copy of CoffeeImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CoffeeImage].
extension CoffeeImagePatterns on CoffeeImage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoffeeImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoffeeImage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoffeeImage value)  $default,){
final _that = this;
switch (_that) {
case _CoffeeImage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoffeeImage value)?  $default,){
final _that = this;
switch (_that) {
case _CoffeeImage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'file')  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoffeeImage() when $default != null:
return $default(_that.imageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'file')  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _CoffeeImage():
return $default(_that.imageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'file')  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _CoffeeImage() when $default != null:
return $default(_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoffeeImage implements CoffeeImage {
  const _CoffeeImage({@JsonKey(name: 'file') required this.imageUrl});
  factory _CoffeeImage.fromJson(Map<String, dynamic> json) => _$CoffeeImageFromJson(json);

/// The file path or URL string for the coffee image.
@override@JsonKey(name: 'file') final  String imageUrl;

/// Create a copy of CoffeeImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoffeeImageCopyWith<_CoffeeImage> get copyWith => __$CoffeeImageCopyWithImpl<_CoffeeImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoffeeImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoffeeImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl);

@override
String toString() {
  return 'CoffeeImage(imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$CoffeeImageCopyWith<$Res> implements $CoffeeImageCopyWith<$Res> {
  factory _$CoffeeImageCopyWith(_CoffeeImage value, $Res Function(_CoffeeImage) _then) = __$CoffeeImageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'file') String imageUrl
});




}
/// @nodoc
class __$CoffeeImageCopyWithImpl<$Res>
    implements _$CoffeeImageCopyWith<$Res> {
  __$CoffeeImageCopyWithImpl(this._self, this._then);

  final _CoffeeImage _self;
  final $Res Function(_CoffeeImage) _then;

/// Create a copy of CoffeeImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,}) {
  return _then(_CoffeeImage(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
