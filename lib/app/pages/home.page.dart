import 'package:flutter/material.dart'
    show
        CircleBorder,
        Colors,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        EdgeInsetsGeometry,
        FloatingActionButton,
        FontWeight,
        GestureDetector,
        Icon,
        Icons,
        MainAxisAlignment,
        Padding,
        Positioned,
        Row,
        SafeArea,
        SizedBox,
        State,
        StatefulWidget,
        Widget,
        WidgetsBinding,
        kToolbarHeight;
import 'package:pokedex/app/bloc/pokemon.bloc.dart'
    show PokemonBloc, PokemonListEvent;
import 'package:pokedex/app/models/pokemon.model.dart' show Pokemon;
import 'package:pokedex/shared/styles/colors/color.dart'
    show PoColor, PowColorToolBase;
import 'package:pokedex/shared/ui/widgets.dart'
    show PoRefreshController, PoUIScaffold, PoUISvg, PoUIText;
import 'package:pokedex/shared/utils/rx.dart' show RxBool, RxList;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonBloc _bloc = PokemonBloc();

  final PoRefreshController _refreshController = PoRefreshController();
  final RxList<Pokemon> _data = RxList<Pokemon>(<Pokemon>[]);
  final RxBool _showLoading = RxBool(false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _refresh() {
    _data.clear();
    _showLoading.value = true;
    _bloc.add(const PokemonListEvent());
  }

  @override
  Widget build(_) => PoUIScaffold(
    background: Positioned(
      top: -96,
      right: -128,
      child: PoUISvg(
        asset: 'assets/svg/pokeball.svg',
        width: 384,
        height: 384,
        color: PoColor.get.grey.withOpacity(.125),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      elevation: 6,
      backgroundColor: Colors.purple,
      shape: const CircleBorder(),
      child: Icon(Icons.tune, color: PoColor.get.textInvert.value),
    ),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _appbar(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PoUIText(
              'Pokedex',
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ],
      ),
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
