import 'package:flutter/material.dart';

/// {@template coffee_image}
/// A stateful widget for coffee images that supports double-tap interactions.
///
/// When double-tapped, it triggers [onTap] and displays a temporary heart
/// animation overlay.
/// {@endtemplate}
class CoffeeImage extends StatefulWidget {
  /// {@macro coffee_image}
  const CoffeeImage({required this.onTap, required this.child, super.key});

  /// Callback triggered when the image is double-tapped.
  final void Function() onTap;

  /// The image widget to display.
  final Widget child;

  @override
  State<CoffeeImage> createState() => _CoffeeImageState();
}

class _CoffeeImageState extends State<CoffeeImage> {
  bool _showHeart = false;

  void _handleDoubleTap() {
    widget.onTap();

    setState(() {
      _showHeart = true;
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          _showHeart = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.child,
          AnimatedOpacity(
            opacity: _showHeart ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: Icon(
              Icons.favorite,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
