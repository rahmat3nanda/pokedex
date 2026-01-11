part of 'pokemon.bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => <Object>[];
}

class PokemonListEvent extends PokemonEvent {
  const PokemonListEvent({this.offset = 0, this.limit = 15});

  final int offset;
  final int limit;
}

class PokemonDetailEvent extends PokemonEvent {
  const PokemonDetailEvent(this.id);

  final String id;
}
