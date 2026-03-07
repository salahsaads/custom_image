import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:omni_image/src/omni_network_image.dart';

/// A universal image widget that handles asset images (PNG, JPG, WebP, SVG, VEC)
/// and network images, with optional gradient color support.
///
/// Example:
/// ```dart
/// OmniImage(
///   image: 'assets/icons/home.svg',
///   width: 24,
///   height: 24,
///   color: Colors.blue,
/// )
/// ```
class OmniImage extends StatelessWidget {
  const OmniImage({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.colors,
    this.radius,
    this.errorWidget,
    this.placeholderWidget,
  });

  /// The image path (asset) or URL (network).
  final String image;

  /// How the image should be inscribed into the space.
  final BoxFit? fit;

  /// The height of the image widget.
  final double? height;

  /// The width of the image widget.
  final double? width;

  /// A single color to apply to the image (uses [BlendMode.srcIn]).
  final Color? color;

  /// A list of colors to apply as a linear gradient overlay.
  /// If provided, [color] is ignored.
  final List<Color>? colors;

  /// Border radius for network images (defaults to 0).
  final double? radius;

  /// Widget to show when image fails to load.
  /// Defaults to an empty [SizedBox] with the given dimensions.
  final Widget? errorWidget;

  /// Widget to show while image is loading (used for .vec format).
  /// Defaults to an empty [SizedBox] with the given dimensions.
  final Widget? placeholderWidget;

  @override
  Widget build(BuildContext context) {
    final imageExtension = image.split('.').last.toLowerCase();
    if (_isNetworkImage(image)) {
      return _buildNetworkImage();
    } else {
      return _buildAssetImage(imageExtension);
    }
  }

  bool _isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  Widget _buildAssetImage(String imageExtension) {
    Widget imageWidget;

    switch (imageExtension) {
      // ⚡ Vector Graphics (.vec) - fastest rendering
      case 'vec':
        imageWidget = SizedBox(
          height: height,
          width: width,
          child: VectorGraphic(
            loader: AssetBytesLoader(image),
            fit: fit ?? BoxFit.cover,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
            placeholderBuilder: (context) =>
                placeholderWidget ??
                SizedBox(
                  height: height ?? 24,
                  width: width ?? 24,
                ),
          ),
        );
        break;

      // 🎨 SVG images
      case 'svg':
        imageWidget = SvgPicture.asset(
          image,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
        break;

      // 🖼️ Raster images (png, jpg, webp, gif, etc.)
      default:
        imageWidget = Image.asset(
          image,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
          cacheWidth: width?.toInt(),
          cacheHeight: height?.toInt(),
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ??
              SizedBox(
                height: height ?? 24,
                width: width ?? 24,
              ),
        );
    }

    return _applyGradient(imageWidget);
  }

  Widget _buildNetworkImage() {
    final imageWidget = OmniNetworkImage(
      image: image,
      fit: fit,
      height: height,
      width: width,
      radius: radius,
      color: color,
      errorWidget: errorWidget,
    );

    return _applyGradient(imageWidget);
  }

  Widget _applyGradient(Widget child) {
    if (colors != null && colors!.isNotEmpty) {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: colors!,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: child,
      );
    }
    return child;
  }
}
