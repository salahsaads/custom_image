# omni_image

[![pub package](https://img.shields.io/pub/v/omni_image.svg)](https://pub.dev/packages/omni_image)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful and flexible Flutter image widget that handles all your image needs in one place.

## ✨ Features

- 🖼️ **Asset images** — PNG, JPG, WebP, GIF
- 🎨 **SVG images** — via `flutter_svg`
- ⚡ **Vector Graphics (.vec)** — fastest rendering via `vector_graphics`
- 🌐 **Network images** — cached automatically via `cached_network_image`
- 🧠 **Memory-safe caching** — resize decoded network images using `memCacheWidth` and `memCacheHeight`
- 🌈 **Gradient color support** — apply linear gradients as color overlays
- 🎨 **Single color tint** — apply a color filter with `BlendMode.srcIn`
- 🔲 **Border radius** — for network images
- 🛡️ **Error & placeholder widgets** — fully customizable fallbacks

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  omni_image: ^0.0.5
```

Then run:

```bash
flutter pub get
```

## 🚀 Usage

Import the package:

```dart
import 'package:omni_image/omni_image.dart';
```

### Asset Image (PNG / JPG / WebP)

```dart
OmniImage(
  image: 'assets/images/photo.png',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)
```

### SVG Asset

```dart
OmniImage(
  image: 'assets/icons/home.svg',
  width: 24,
  height: 24,
  color: Colors.blue,
)
```

### Vector Graphic (.vec) — Best Performance

```dart
OmniImage(
  image: 'assets/icons/star.vec',
  width: 32,
  height: 32,
  color: Colors.amber,
)
```

### Network Image with Caching

```dart
OmniImage(
  image: 'https://example.com/photo.jpg',
  width: 200,
  height: 200,
  radius: 12,
)
```

### Network Image with Memory-Safe Cache Resize

```dart
OmniImage(
  image: 'https://example.com/large-photo.jpg',
  width: 300,
  height: 200,
  fit: BoxFit.cover,
  memCacheWidth: 600,
  memCacheHeight: 400,
)
```

Use this when loading large images (HD/4K) to reduce RAM usage and avoid out-of-memory crashes in long sessions.

### Gradient Color Overlay

```dart
OmniImage(
  image: 'assets/icons/heart.svg',
  width: 48,
  height: 48,
  colors: [Colors.purple, Colors.pink, Colors.orange],
)
```

### Custom Error & Placeholder

```dart
OmniImage(
  image: 'https://example.com/photo.jpg',
  width: 100,
  height: 100,
  errorWidget: const Icon(Icons.broken_image, color: Colors.grey),
  placeholderWidget: const CircularProgressIndicator(),
)
```

## 🔧 Parameters

### `OmniImage`

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `image` | `String` | **required** | Asset path or network URL |
| `width` | `double?` | `null` | Widget width |
| `height` | `double?` | `null` | Widget height |
| `fit` | `BoxFit?` | `BoxFit.cover` | How the image fits its bounds |
| `color` | `Color?` | `null` | Single color tint |
| `colors` | `List<Color>?` | `null` | Gradient color overlay |
| `radius` | `double?` | `0` | Border radius (network only) |
| `errorWidget` | `Widget?` | `SizedBox` | Shown on load error |
| `placeholderWidget` | `Widget?` | `SizedBox` | Shown while loading (.vec) |
| `memCacheWidth` | `int?` | `null` | Decoded network image width in memory cache |
| `memCacheHeight` | `int?` | `null` | Decoded network image height in memory cache |

### `OmniNetworkImage`

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `image` | `String` | **required** | Network URL |
| `width` | `double?` | `null` | Widget width |
| `height` | `double?` | `null` | Widget height |
| `fit` | `BoxFit?` | `BoxFit.cover` | How the image fits its bounds |
| `color` | `Color?` | `null` | Color filter |
| `radius` | `double?` | `0` | Border radius |
| `errorWidget` | `Widget?` | `SizedBox` | Shown on load error |
| `placeholder` | `Widget?` | `null` | Shown while loading |
| `memCacheWidth` | `int?` | `null` | Decoded image width in memory cache |
| `memCacheHeight` | `int?` | `null` | Decoded image height in memory cache |

## 🏗️ How It Works

`OmniImage` automatically detects the image type by:

1. Checking if the URL starts with `http://` or `https://` → uses `OmniNetworkImage`
2. Reading the file extension → picks the right renderer:
   - `.vec` → `VectorGraphic` (fastest)
   - `.svg` → `SvgPicture`
   - Everything else → `Image.asset`

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.
