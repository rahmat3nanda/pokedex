import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Emitter;
import 'package:pokedex/app/models/pokemon.model.dart' show Pokemon;
import 'package:pokedex/app/pokemon.endpoints.dart' show PokemonEndpoints;
import 'package:pokedex/cores/core/bloc.dart' show AppBloc;
import 'package:pokedex/cores/core/jsonable.dart' show JsonTrim;
import 'package:pokedex/cores/networking/endpoints.interface.dart'
    show EndpointCustom;
import 'package:pokedex/cores/networking/http_client/dio.client.dart'
    show PoDioHttpClient;
import 'package:pokedex/cores/networking/http_client/paging.response.dart'
    show PagingResponse;

part 'pokemon.event.dart';
part 'pokemon.state.dart';

class PokemonBloc extends AppBloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(const PokemonInitialState()) {
    when<PokemonListEvent>(_loadList);
    when<PokemonDetailEvent>(_loadDetail);
  }

  @override
  PokemonState get resetState => const PokemonInitialState();

  Future<void> _loadList(
    PokemonListEvent event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      emit(const PokemonListLoadingState(true));
      final PagingResponse<Pokemon> pr = await PoDioHttpClient.i
          .get<PagingResponse<Pokemon>>(
            PokemonEndpoints.list,
            params: <String, dynamic>{
              'offset': event.offset,
              'limit': event.limit,
            }.trim,
            creator: () => const PagingResponse<Pokemon>(creator: Pokemon.new),
          );
      emit(const PokemonListLoadingState(false));
      emit(PokemonListSuccessState(pr.results ?? <Pokemon>[]));
    } catch (e) {
      emit(const PokemonListLoadingState(false));

      emit(PokemonListFailureState(e));
    }
  }

  Future<void> _loadDetail(
    PokemonDetailEvent event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      emit(const PokemonDetailLoadingState(true));
      final Pokemon res = await PoDioHttpClient.i.get(
        PokemonEndpoints.detail.resolve(event.id),
        creator: Pokemon.new,
      );
      emit(const PokemonDetailLoadingState(false));
      emit(PokemonDetailSuccessState(res));
    } catch (e) {
      emit(const PokemonDetailLoadingState(false));
      emit(PokemonDetailFailureState(e));
    }
  }
}
