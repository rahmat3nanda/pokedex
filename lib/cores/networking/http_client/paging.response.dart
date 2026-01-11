import 'package:pokedex/cores/core/jsonable.dart' show Json, JsonTrim, Jsonable;
import 'package:pokedex/cores/core/typedef.dart' show Creator;

class PagingResponse<T extends Jsonable<T>>
    extends Jsonable<PagingResponse<T>> {
  const PagingResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
    this.creator,
  });

  final int? count;
  final String? next;
  final String? previous;
  final List<T>? results;
  final Creator<Jsonable<T>>? creator;

  @override
  PagingResponse<T>? decode(Json? json) {
    if (json == null) return null;
    return PagingResponse<T>(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((dynamic e) => creator?.call().decode(e))
          .whereType<T>()
          .toList(),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': results?.map((T e) => e.encode()).toList(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[count, next, previous, results];
}
