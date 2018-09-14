import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  testWidgets('should not crash', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Image.network('https://example.com/image.png'),
        ),
      );
    });
  });
}
