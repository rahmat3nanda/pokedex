import 'package:dio/dio.dart'
    show
        BaseOptions,
        Dio,
        DioException,
        Interceptor,
        Options,
        RequestOptions,
        Response;
import 'package:pokedex/cores/core/env.dart' show PoEnv;
import 'package:pokedex/cores/core/jsonable.dart' show Json, JsonTrim, Jsonable;
import 'package:pokedex/cores/core/logger.dart' show PoLogger;
import 'package:pokedex/cores/core/typedef.dart' show Creator;
import 'package:pokedex/cores/networking/endpoints.interface.dart'
    show Endpoints;
import 'package:pokedex/cores/networking/http_client/interceptors/logging.dio.interceptor.dart'
    show LoggingDioInterceptor;

class PoDioHttpClient {
  factory PoDioHttpClient() => _instance;

  PoDioHttpClient._();

  late final Dio _client;

  static final PoDioHttpClient _instance = PoDioHttpClient._();

  static PoDioHttpClient get i => _instance;

  static Future<void> initialize() async {
    _instance._client = Dio(BaseOptions(baseUrl: PoEnv.i.baseUrl))
      ..interceptors.addAll(<Interceptor>[LoggingDioInterceptor(_instance)]);
  }

  Future<T> get<T extends Jsonable<T>>(
    Endpoints endpoint, {
    Json? params,
    Creator<Jsonable<T>>? creator,
  }) => request<T>(
    endpoint: endpoint,
    method: _Method.get,
    params: params?.trim,
    creator: creator,
  );

  void logger(dynamic message) => PoLogger.i.info(message);

  Future<Response<T>> fetch<T>(RequestOptions requestOptions) =>
      _client.fetch(requestOptions);
}

extension _PoDioHttpClient on PoDioHttpClient {
  Future<T> request<T extends Jsonable<T>>({
    required Endpoints endpoint,
    required _Method method,
    Json? params,
    Json? body,
    Creator<Jsonable<T>>? creator,
  }) async {
    try {
      final Response<dynamic> res = await _client.request(
        endpoint.value,
        data: body,
        queryParameters: params,
        options: Options(
          method: method.value,
          extra: <String, Object?>{'title': endpoint.title},
        ),
      );

      final dynamic raw = res.data;
      dynamic data;

      if (raw is List && creator != null) {
        data = creator().dynamicDecode(raw);
      } else if (raw is Map && creator != null) {
        data = creator().decode(raw as Json?);
      } else {
        data = raw as T?;
      }

      return data;
    } on DioException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}

enum _Method {
  get;

  String get value => name.toUpperCase();
}
