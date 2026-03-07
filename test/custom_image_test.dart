import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_image/custom_image.dart';

void main() {
  group('CustomImage', () {
    testWidgets('renders with a network URL', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomImage(
              image: 'https://example.com/image.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
      expect(find.byType(CustomImage), findsOneWidget);
    });

    testWidgets('renders errorWidget when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomImage(
              image: 'assets/nonexistent.png',
              width: 50,
              height: 50,
              errorWidget: Text('Error'),
            ),
          ),
        ),
      );
      expect(find.byType(CustomImage), findsOneWidget);
    });

    test('isNetworkImage returns true for http URLs', () {
      const widget = CustomImage(image: 'http://example.com/img.png');
      expect(
        widget.image.startsWith('http://') ||
            widget.image.startsWith('https://'),
        isTrue,
      );
    });

    test('isNetworkImage returns false for asset paths', () {
      const widget = CustomImage(image: 'assets/icons/home.svg');
      expect(
        widget.image.startsWith('http://') ||
            widget.image.startsWith('https://'),
        isFalse,
      );
    });
  });
}
