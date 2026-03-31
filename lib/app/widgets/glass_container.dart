import 'dart:ui';

import 'package:flutter/material.dart';

/// A glassmorphic container with backdrop blur, translucent fill,
/// and a subtle ghost border.
class GlassContainer extends StatelessWidget {
  /// Creates a glassmorphic container.
  const GlassContainer({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = 32,
    this.blurSigma = 16,
    super.key,
  });

  /// The content inside the glass container.
  final Widget child;

  /// Padding around [child].
  final EdgeInsets padding;

  /// Corner radius of the container.
  final double borderRadius;

  /// Blur intensity for the backdrop filter.
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(borderRadius);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.6),
            borderRadius: radius,
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
