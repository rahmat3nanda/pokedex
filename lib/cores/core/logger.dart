import 'package:logger/logger.dart'
    show AnsiColor, Level, Logger, PrettyPrinter;
import 'package:meta/meta.dart' show protected;

@protected
class PoLogger {
  factory PoLogger() => _instance;

  PoLogger._();

  final PrettyPrinter _pp = PrettyPrinter();
  final Logger _log = _create();

  static final PoLogger _instance = PoLogger._();

  static PoLogger get i => _instance;

  static Logger _create({
    AnsiColor? color,
    int methodCount = 0,
    bool noBoxingByDefault = false,
  }) => Logger(
    printer: PrettyPrinter(
      levelColors: color != null
          ? <Level, AnsiColor>{
              Level.debug: color,
              Level.info: color,
              Level.warning: color,
              Level.error: color,
            }
          : null,
      methodCount: methodCount,
      noBoxingByDefault: noBoxingByDefault,
      printEmojis: false,
    ),
  );

  String jsonify(dynamic message) =>
      message == null ? 'null' : _pp.stringifyMessage(message);

  void info(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => _log.i(message, time: time, error: error, stackTrace: stackTrace);

  void warning(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => _log.w(message, time: time, error: error, stackTrace: stackTrace);

  void debug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => _log.d(message, time: time, error: error, stackTrace: stackTrace);

  void verbose(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => _log.t(message, time: time, error: error, stackTrace: stackTrace);

  void fatal(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => _log.f(message, time: time, error: error, stackTrace: stackTrace);
}
