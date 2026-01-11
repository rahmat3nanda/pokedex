import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, StateStreamableSource;
import 'package:pokedex/app/bloc/pokemon.bloc.dart' show PokemonBloc;
import 'package:pokedex/cores/core/typedef.dart' show Creator;

class AppProvider {
  const AppProvider();

  static List<BlocProvider<dynamic>> get list =>
      _creates(<Creator<_Bloc>>[PokemonBloc.new]);
}

BlocProvider<_Bloc> _create<T extends _Bloc>(Creator<T> creator) =>
    BlocProvider<T>(create: (_) => creator());

List<BlocProvider<dynamic>> _creates(List<Creator<_Bloc>> creators) =>
    creators.map(_create).toList();

typedef _Bloc = StateStreamableSource<Object?>;
