import 'dart:async' show FutureOr, unawaited;

typedef GetLocal<T> = FutureOr<T?> Function();
typedef SetLocal<T> = FutureOr<void> Function(T data);
typedef FetchRemote<T> = FutureOr<T> Function();
typedef OnLoadingRemote = void Function(bool isLoading);
typedef OnDataRemote<T> = void Function(T data);
typedef OnErrorRemote = void Function(dynamic error);

class FloLoaderLocal<T> {
  const FloLoaderLocal({required this.get, required this.set});

  final GetLocal<T> get;
  final SetLocal<T> set;
}

class FloLoaderRemote<T> {
  const FloLoaderRemote({
    required this.fetch,
    this.onLoading,
    this.onData,
    this.onError,
  });

  final FetchRemote<T> fetch;
  final OnLoadingRemote? onLoading;
  final OnDataRemote<T>? onData;
  final OnErrorRemote? onError;
}

class FloLoader {
  const FloLoader();

  static Future<T> load<T>({
    required FloLoaderLocal<T> local,
    required FloLoaderRemote<T> remote,
  }) async {
    final T? localData = await local.get();
    if (localData != null) {
      unawaited(
        Future<void>.microtask(() async {
          remote.onLoading?.call(true);
          try {
            final T remoteData = await remote.fetch();
            local.set(remoteData);
            remote.onData?.call(remoteData);
          } catch (e) {
            remote.onError?.call(e);
          } finally {
            remote.onLoading?.call(false);
          }
        }),
      );
      return localData;
    }

    remote.onLoading?.call(true);
    try {
      final T remoteData = await remote.fetch();
      await local.set(remoteData);
      remote.onData?.call(remoteData);
      return remoteData;
    } catch (e) {
      rethrow;
    } finally {
      remote.onLoading?.call(false);
    }
  }
}
