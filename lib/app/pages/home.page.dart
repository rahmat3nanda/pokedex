import 'package:flutter/material.dart'
    show
        EdgeInsetsGeometry,
        GestureDetector,
        Icon,
        Icons,
        MainAxisAlignment,
        Padding,
        Positioned,
        Row,
        SafeArea,
        SizedBox,
        Stack,
        State,
        StatefulWidget,
        Widget,
        kToolbarHeight;
import 'package:pokedex/shared/styles/colors/color.dart'
    show PoColor, PowColorToolBase;
import 'package:pokedex/shared/ui/widgets.dart' show PoUIScaffold, PoUISvg;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(_) => PoUIScaffold(
    background: Stack(
      children: <Widget>[
        Positioned(
          top: -96,
          right: -128,
          child: PoUISvg(
            asset: 'assets/svg/pokeball.svg',
            width: 384,
            height: 384,
            color: PoColor.get.grey.withOpacity(.125),
          ),
        ),
        _appbar(),
      ],
    ),
  );

  Widget _appbar() => SafeArea(
    child: SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Icon(Icons.list, color: PoColor.get.text.value),
            ),
          ),
        ],
      ),
    ),
  );
}
