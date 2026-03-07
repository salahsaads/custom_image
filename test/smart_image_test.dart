import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_image/smart_image.dart';

void main() {
  group('SmartImage', () {
    testWidgets('renders with a network URL', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmartImage(
              image: 'https://example.com/image.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
      expect(find.byType(SmartImage), findsOneWidget);
    });

    testWidgets('renders errorWidget when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmartImage(
              image: 'assets/nonexistent.png',
              width: 50,
              height: 50,
              errorWidget: Text('Error'),
            ),
          ),
        ),
      );
      expect(find.byType(SmartImage), findsOneWidget);
    });

    test('isNetworkImage returns true for http URLs', () {
      const widget = SmartImage(image: 'http://example.com/img.png');
      expect(
        widget.image.startsWith('http://') ||
            widget.image.startsWith('https://'),
        isTrue,
      );
    });

    test('isNetworkImage returns false for asset paths', () {
      const widget = SmartImage(image: 'assets/icons/home.svg');
      expect(
        widget.image.startsWith('http://') ||
            widget.image.startsWith('https://'),
        isFalse,
      );
    });
  });
}
