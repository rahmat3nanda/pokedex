import 'package:flutter/material.dart'
    show
        AppBar,
        PreferredSizeWidget,
        Size,
        SizedBox,
        StatelessWidget,
        Widget,
        kToolbarHeight;
import 'package:pokedex/shared/styles/colors/color.dart'
    show PoColor, PoColorBase;

class PoUIAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PoUIAppBar({
    this.toolbarHeight,
    this.backgroundColor,
    this.child = const SizedBox.shrink(),
    super.key,
  });

  factory PoUIAppBar.empty() =>
      PoUIAppBar(toolbarHeight: 0, backgroundColor: PoColor.get.transparent);

  final double? toolbarHeight;
  final PoColorBase? backgroundColor;
  final Widget child;

  @override
  Widget build(_) => AppBar(
    toolbarHeight: toolbarHeight,
    backgroundColor: backgroundColor?.value,
  );

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
