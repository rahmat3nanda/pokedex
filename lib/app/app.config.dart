import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart'
    show ColoredBox, Colors, ErrorWidget, WidgetsFlutterBinding;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:flutter_bloc/flutter_bloc.dart'
    show Bloc, BlocBase, BlocObserver, Transition;
import 'package:pokedex/cores/core/env.dart' show PoEnv, PoEnvType;
import 'package:pokedex/cores/core/logger.dart' show PoLogger;
import 'package:pokedex/cores/networking/http_client/dio.client.dart'
    show PoDioHttpClient;

class AppConfig {
  factory AppConfig() => _instance;

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  static AppConfig get i => _instance;

  static Future<void> initialize(PoEnvType type) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (kReleaseMode) {
      ErrorWidget.builder = (_) => const ColoredBox(color: Colors.transparent);
    }

    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await PoEnv.initialize(type);
    await PoDioHttpClient.initialize();

    Bloc.observer = _Observer();
  }
}

class _Observer extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    PoLogger.i.info('${bloc.runtimeType} $event');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    PoLogger.i.info(transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    PoLogger.i.fatal('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }
}
