import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A cached network image widget with optional color filter,
/// border radius, and error/placeholder support.
///
/// Uses [CachedNetworkImage] for efficient image caching.
///
/// Example:
/// ```dart
/// CustomNetworkImage(
///   image: 'https://example.com/photo.jpg',
///   width: 100,
///   height: 100,
///   radius: 12,
/// )
/// ```
class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.radius,
    this.color,
    this.errorWidget,
    this.placeholder,
  });

  /// The network URL of the image.
  final String image;

  /// How the image should be inscribed into the space.
  final BoxFit? fit;

  /// The height of the image widget.
  final double? height;

  /// The width of the image widget.
  final double? width;

  /// Border radius for clipping the image. Defaults to 0.
  final double? radius;

  /// A color to apply on top of the image using [BlendMode.srcIn].
  final Color? color;

  /// Widget to show when image fails to load.
  final Widget? errorWidget;

  /// Widget to show while image is loading.
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: image,
      fit: fit ?? BoxFit.cover,
      placeholder: placeholder != null
          ? (context, url) => placeholder!
          : null,
      errorWidget: errorWidget != null
          ? (context, url, error) => errorWidget!
          : (context, url, error) => SizedBox(
                height: height ?? 24,
                width: width ?? 24,
              ),
    );

    if (color != null) {
      imageWidget = ColorFiltered(
        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
        child: imageWidget,
      );
    }

    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: imageWidget,
      ),
    );
  }
} 