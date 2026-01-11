part of 'pokemon.bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => <Object>[];
}

class PokemonInitialState extends PokemonState {
  const PokemonInitialState();
}

class PokemonListLoadingState extends PokemonState {
  const PokemonListLoadingState(this.loading);

  final bool loading;

  @override
  List<Object> get props => <Object>[loading];
}

class PokemonListSuccessState extends PokemonState {
  const PokemonListSuccessState(this.data);

  final List<Pokemon> data;
}

class PokemonListFailureState extends PokemonState {
  const PokemonListFailureState(this.error);

  final Object error;
}

class PokemonDetailLoadingState extends PokemonState {
  const PokemonDetailLoadingState(this.loading);

  final bool loading;

  @override
  List<Object> get props => <Object>[loading];
}

class PokemonDetailSuccessState extends PokemonState {
  const PokemonDetailSuccessState(this.data);

  final Pokemon data;
}

class PokemonDetailFailureState extends PokemonState {
  const PokemonDetailFailureState(this.error);

  final Object error;
}
