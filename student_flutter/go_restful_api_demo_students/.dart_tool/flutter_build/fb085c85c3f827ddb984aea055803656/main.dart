// @dart=2.17
// Flutter web bootstrap script for package:go_restful_api_demo_students/main.dart.

import 'dart:ui' as ui;
import 'dart:async';

import 'package:go_restful_api_demo_students/main.dart' as entrypoint;

typedef _UnaryFunction = dynamic Function(List<String> args);
typedef _NullaryFunction = dynamic Function();

Future<void> main() async {
  await ui.webOnlyWarmupEngine(
    runApp: () {
      if (entrypoint.main is _UnaryFunction) {
        return (entrypoint.main as _UnaryFunction)(<String>[]);
      }
      return (entrypoint.main as _NullaryFunction)();
    },
  );
}
