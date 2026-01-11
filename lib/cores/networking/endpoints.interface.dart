abstract mixin class Endpoints {
  const Endpoints();

  String get title;

  String get path;

  String get value => path.startsWith('/') ? path.substring(1) : path;
}

class CustomEndpoints with Endpoints {
  const CustomEndpoints(this.title, this.path);

  @override
  final String title;

  @override
  final String path;
}

extension EndpointCustom on Endpoints {
  String get placeholder => ':id';

  Endpoints resolve(String path) =>
      CustomEndpoints(title, this.path.replaceAll(placeholder, path));

  Endpoints setBaseUrl(String baseUrl) {
    final String cleanedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final String cleanedValue = path.startsWith('/') ? path : '/$path';
    return CustomEndpoints(title, '$cleanedBase$cleanedValue');
  }
}
