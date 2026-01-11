import 'dart:async' show FutureOr;

import 'package:flutter_bloc/flutter_bloc.dart'
    show Bloc, Emitter, EventTransformer;
import 'package:pokedex/cores/core/logger.dart' show PoLogger;

abstract class AppBloc<E, S> extends Bloc<E, S> {
  AppBloc(super.initialState);

  S get resetState;

  void when<T extends E>(
    FutureOr<void> Function(T event, Emitter<S> emit) handler, {
    EventTransformer<T>? transformer,
  }) {
    on<T>((T event, Emitter<S> emit) async {
      emit(resetState);
      await handler(event, emit);
    }, transformer: transformer);
  }

  void onInit() {
    PoLogger.i.debug('AppBloc: $runtimeType initialized');
  }

  void onDispose() {
    PoLogger.i.debug('AppBloc: $runtimeType disposed');
  }
}
