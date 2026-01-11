import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart'
    show
        AnimatedBuilder,
        BuildContext,
        Listenable,
        StatelessWidget,
        ValueListenableBuilder,
        Widget,
        WidgetBuilder;
import 'package:pokedex/shared/utils/rx/type.dart';

class RxBuilder<T> extends StatelessWidget {
  const RxBuilder({required this.rx, required this.builder, super.key});

  final Rx<T> rx;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<T>(
    valueListenable: rx,
    builder: (BuildContext context, T value, _) => builder(context, value),
  );
}

class RxBuilderGroup extends StatelessWidget {
  const RxBuilderGroup({
    required this.rxList,
    required this.builder,
    super.key,
  });

  final List<ValueListenable<dynamic>> rxList;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: Listenable.merge(rxList),
    builder: (BuildContext context, _) => builder(context),
  );
}
