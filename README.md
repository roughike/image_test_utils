# image_test_utils

[![pub package](https://img.shields.io/pub/v/image_test_utils.svg)](https://pub.dartlang.org/packages/image_test_utils)
 [![Build Status](https://travis-ci.org/roughike/image_test_utils.svg?branch=master)](https://travis-ci.org/roughike/image_test_utils) 

Without providing mocked responses, any widget test that pumps up `Image.network` widgets will crash.

[There's a blog post that goes more into detail on this.](https://iirokrankka.com/2018/09/16/image-network-widget-tests/)

Copy-pasting [the code for mocking the image responses](https://github.com/flutter/flutter/blob/master/dev/manual_tests/test/mock_image_http.dart) to every new project gets a little boring. This helper library makes it easier to provide those mocked image responses.

## Usage

First, depend on the library:

**pubspec.yaml**

```yaml
dev_dependencies:
  image_test_utils: ^1.0.0
```

Note that this library should be included in your `dev_dependencies` block; **not in your regular `dependencies`**.

In your widget tests, import the library and wrap your widget test in a `provideMockedNetworkImages` method.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  testWidgets('should not crash', (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      /// Now we can pump NetworkImages without crashing our tests. Yay!
      await tester.pumpWidget(
        MaterialApp(
          home: Image.network('https://example.com/image.png'),
        ),
      );
      
      /// Other test code goes here.
    });
  });
}
```

All HTTP GET requests inside the closure of `provideMockedNetworkImages` will receive a mocked image response, and your tests will not crash with 404's anymore.
