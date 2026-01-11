import 'package:flutter_dotenv/flutter_dotenv.dart' show DotEnv;

enum PoEnvType {
  prod;

  String get file => switch (this) {
    PoEnvType.prod => '.env',
  };
}

class PoEnv {
  factory PoEnv() => _instance;

  PoEnv._();

  static final PoEnv _instance = PoEnv._();

  static PoEnv get i => _instance;

  static Future<void> initialize(PoEnvType type) async {
    await i._env.load(fileName: type.file);
    i.baseUrl = i._env.maybeGet('BASE_URL') ?? '';
    i.svgUrl = i._env.maybeGet('SVG_URL') ?? '';
  }

  final DotEnv _env = DotEnv();

  late final String baseUrl;
  late final String svgUrl;
}
