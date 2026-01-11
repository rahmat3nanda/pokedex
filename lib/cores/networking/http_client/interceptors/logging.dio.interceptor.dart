import 'package:dio/dio.dart'
    show
        DioException,
        ErrorInterceptorHandler,
        Interceptor,
        RequestInterceptorHandler,
        RequestOptions,
        Response,
        ResponseInterceptorHandler;
import 'package:pokedex/cores/networking/http_client/dio.client.dart'
    show PoDioHttpClient;

class LoggingDioInterceptor extends Interceptor {
  LoggingDioInterceptor(this.client);

  final PoDioHttpClient client;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    client.logger('========== Info ==========');
    client.logger(<String, dynamic>{
      'method': options.method,
      'url': options.uri.toString(),
      'extra': options.extra,
      'receive_timeout': options.receiveTimeout,
      'send_timeout': options.sendTimeout,
    });
    client.logger('===========================');
    client.logger('========== Headers ==========');
    client.logger(<String, dynamic>{...options.headers});
    client.logger('===========================');

    if (options.data != null) {
      client.logger('========== Body ==========');
      client.logger(options.data);
      client.logger('===========================');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> result,
    ResponseInterceptorHandler handler,
  ) {
    if (result.data != null) {
      client.logger('========== Response ==========');
      client.logger(<String, dynamic>{
        'status_code': result.statusCode,
        'status_message': result.statusMessage,
        'data': result.data,
      });
      client.logger('===========================');
    }

    super.onResponse(result, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.data != null) {
      client.logger('========== Error Response ==========');
      client.logger(err.response?.data);
      client.logger('===========================');
    }

    super.onError(err, handler);
  }
}
