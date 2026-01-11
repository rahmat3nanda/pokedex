import 'dart:async' show runZonedGuarded;

import 'package:flutter/material.dart' show runApp;
import 'package:pokedex/app/app.config.dart' show AppConfig;
import 'package:pokedex/app/app.dart' show App;
import 'package:pokedex/cores/core/env.dart' show PoEnvType;
import 'package:pokedex/cores/core/logger.dart' show PoLogger;

void main() {
  runZonedGuarded(
    () async {
      await AppConfig.initialize(PoEnvType.prod);
      runApp(const App());
    },
    (Object exception, StackTrace stackTrace) {
      PoLogger.i.fatal('$exception\n$stackTrace');
    },
  );
}
