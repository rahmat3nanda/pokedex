import 'package:flutter/material.dart'
    show
        FloatingActionButtonLocation,
        PreferredSizeWidget,
        Scaffold,
        Stack,
        StackFit,
        StatelessWidget,
        Widget;

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
  Widget build(_) => Stack(
    fit: StackFit.expand,
    children: <Widget>[
      if (background != null) background!,
      Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        extendBody: extendBody,
      ),
    ],
  );
}
