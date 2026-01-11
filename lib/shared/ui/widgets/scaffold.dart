import 'package:flutter/material.dart'
    show
        ColoredBox,
        FloatingActionButtonLocation,
        Material,
        PreferredSizeWidget,
        Scaffold,
        Stack,
        StackFit,
        StatelessWidget,
        Widget;
import 'package:pokedex/shared/styles/colors/color.dart' show PoColor;

class PoUIScaffold extends StatelessWidget {
  const PoUIScaffold({
    this.appBar,
    this.body,
    this.topSafeArea = true,
    this.leftSafeArea = true,
    this.bottomSafeArea = true,
    this.rightSafeArea = true,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.background,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final bool topSafeArea;
  final bool leftSafeArea;
  final bool bottomSafeArea;
  final bool rightSafeArea;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? background;
  final bool extendBodyBehindAppBar;
  final bool extendBody;

  @override
  Widget build(_) => Material(
    color: PoColor.get.transparent.value,
    child: ColoredBox(
      color: PoColor.get.scaffold.value,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (background != null) background!,
          Scaffold(
            appBar: appBar,
            body: body,
            backgroundColor: PoColor.get.transparent.value,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            extendBody: extendBody,
          ),
        ],
      ),
    ),
  );
}
