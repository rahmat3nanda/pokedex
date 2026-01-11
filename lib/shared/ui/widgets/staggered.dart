import 'package:flutter/material.dart'
    show
        Axis,
        BuildContext,
        Clip,
        StatelessWidget,
        TextDirection,
        VerticalDirection,
        Widget,
        Wrap,
        WrapAlignment,
        WrapCrossAlignment;

class PoUIStaggered extends StatelessWidget {
  const PoUIStaggered({
    required this.children,
    this.horizontalSpacing = 8,
    this.verticalSpacing = 8,
    this.direction = Axis.horizontal,
    this.textDirection,
    this.wrapMainAxisAlignment = WrapAlignment.start,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.clipBehavior = Clip.none,
    this.verticalDirection = VerticalDirection.down,
    super.key,
  });

  factory PoUIStaggered.builder({
    required int itemCount,
    required Widget Function(int index) builder,
    double horizontalSpacing = 8,
    double verticalSpacing = 8,
    Axis direction = Axis.horizontal,
    TextDirection? textDirection,
    WrapAlignment wrapMainAxisAlignment = WrapAlignment.start,
    WrapCrossAlignment wrapCrossAxisAlignment = WrapCrossAlignment.start,
    Clip clipBehavior = Clip.none,
    VerticalDirection verticalDirection = VerticalDirection.down,
  }) => PoUIStaggered(
    horizontalSpacing: horizontalSpacing,
    verticalSpacing: verticalSpacing,
    direction: direction,
    textDirection: textDirection,
    wrapMainAxisAlignment: wrapMainAxisAlignment,
    wrapCrossAxisAlignment: wrapCrossAxisAlignment,
    clipBehavior: clipBehavior,
    verticalDirection: verticalDirection,
    children: List<Widget>.generate(itemCount, (int i) => builder(i)),
  );

  factory PoUIStaggered.separated({
    required int itemCount,
    required Widget Function(int index) separatorBuilder,
    required Widget Function(int index) itePouilder,
    double horizontalSpacing = 8,
    double verticalSpacing = 8,
    Axis direction = Axis.horizontal,
    TextDirection? textDirection,
    WrapAlignment wrapMainAxisAlignment = WrapAlignment.start,
    WrapCrossAlignment wrapCrossAxisAlignment = WrapCrossAlignment.start,
    Clip clipBehavior = Clip.none,
    VerticalDirection verticalDirection = VerticalDirection.down,
  }) {
    List<Widget> children = <Widget>[];
    if (itemCount > 0) {
      children = List<Widget>.generate((itemCount * 2) - 1, (int index) {
        if (index.isEven) {
          return itePouilder(index ~/ 2);
        } else {
          return separatorBuilder(index ~/ 2);
        }
      });
    }

    return PoUIStaggered(
      horizontalSpacing: horizontalSpacing,
      verticalSpacing: verticalSpacing,
      direction: direction,
      textDirection: textDirection,
      wrapMainAxisAlignment: wrapMainAxisAlignment,
      wrapCrossAxisAlignment: wrapCrossAxisAlignment,
      clipBehavior: clipBehavior,
      verticalDirection: verticalDirection,
      children: children,
    );
  }

  final List<Widget> children;
  final double horizontalSpacing;
  final double verticalSpacing;
  final Axis direction;
  final TextDirection? textDirection;
  final WrapAlignment wrapMainAxisAlignment;
  final WrapCrossAlignment wrapCrossAxisAlignment;
  final Clip clipBehavior;
  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) => Wrap(
    crossAxisAlignment: wrapCrossAxisAlignment,
    alignment: wrapMainAxisAlignment,
    runSpacing: verticalSpacing,
    direction: direction,
    spacing: horizontalSpacing,
    textDirection: textDirection,
    clipBehavior: clipBehavior,
    verticalDirection: verticalDirection,
    children: children,
  );
}
