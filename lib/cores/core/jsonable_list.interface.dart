import 'package:pokedex/cores/core/jsonable.dart' show Json, Jsonable;
import 'package:pokedex/cores/core/typedef.dart' show Creator;

ListJsonable<T> listOf<T extends Jsonable<T>>(Creator<T> creator) =>
    ListJsonable<T>(creator);

class ListJsonable<T extends Jsonable<T>> extends Jsonable<List<T>> {
  const ListJsonable(this.itemCreator);

  final Creator<T> itemCreator;

  @override
  List<T>? dynamicDecode(dynamic json) {
    if (json is! List) return null;
    return json
        .map((dynamic e) => itemCreator().decode(e as Json))
        .whereType<T>()
        .toList();
  }

  @override
  List<Json> dynamicEncode([List<T>? data]) =>
      data?.map((T e) => e.encode()).toList() ?? <Json>[];

  @override
  List<T>? decode(Json? json) => throw UnimplementedError();

  @override
  Json encode() => throw UnimplementedError();

  @override
  List<Object?> get props => <Object?>[itemCreator];
}
