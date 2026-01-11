import 'package:flutter/material.dart'
    show
        SliverAppBar,
        SliverFillRemaining,
        SliverFillViewport,
        SliverFixedExtentList,
        SliverGrid,
        SliverLayoutBuilder,
        SliverList,
        SliverPadding,
        SliverToBoxAdapter,
        Widget;
import 'package:pokedex/shared/ui/widgets.dart' show SliverCenter;

extension WidgetSliver on Widget {
  bool get isSliver =>
      this is SliverList ||
      this is SliverGrid ||
      this is SliverToBoxAdapter ||
      this is SliverPadding ||
      this is SliverAppBar ||
      this is SliverFixedExtentList ||
      this is SliverLayoutBuilder ||
      this is SliverFillRemaining ||
      this is SliverFillViewport ||
      this is SliverCenter;
}
