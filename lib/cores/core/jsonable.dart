import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:equatable/equatable.dart' show Equatable;
import 'package:pokedex/cores/core/typedef.dart' show Creator;

typedef Json = Map<String, dynamic>;

String? tryJsonEncode(dynamic data) {
  if (data == null) return null;
  try {
    return jsonEncode(data);
  } catch (_) {
    return null;
  }
}

dynamic tryJsonDecode(dynamic data) {
  if (data == null) return null;
  if (data is! String) return null;
  try {
    return jsonDecode(data);
  } catch (_) {
    return null;
  }
}

abstract class Jsonable<T> extends Equatable {
  const Jsonable();

  T? decode(Json? json);

  Json encode();

  T? dynamicDecode(dynamic json) => null;

  dynamic dynamicEncode([T? data]) => null;

  T create(Creator<T> creator) => creator();

  String? encodeToString() => tryJsonEncode(encode().trim);

  T? decodeFromString(String? json) => decode(tryJsonDecode(json));

  @override
  List<Object?> get props;
}

extension JsonTrim on Json {
  Json get trim => Json.fromEntries(
    entries.where((MapEntry<String, dynamic> e) => e.value != null),
  );
}
