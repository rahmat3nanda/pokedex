import 'package:flutter/material.dart'
    show
        CircleBorder,
        Colors,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        EdgeInsetsGeometry,
        Expanded,
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
        SliverAppBar,
        State,
        StatefulWidget,
        Widget,
        WidgetsBinding,
        kToolbarHeight;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener;
import 'package:pokedex/app/bloc/pokemon.bloc.dart'
    show
        PokemonBloc,
        PokemonListEvent,
        PokemonListFailureState,
        PokemonListLoadingState,
        PokemonListSuccessState,
        PokemonState;
import 'package:pokedex/app/models/pokemon.model.dart' show Pokemon;
import 'package:pokedex/shared/styles/colors/color.dart'
    show PoColor, PowColorToolBase;
import 'package:pokedex/shared/ui/widgets.dart'
    show
        PoRefreshController,
        PoRefreshControllerExtension,
        PoUIInfiniteListView,
        PoUIInfiniteListViewRefresh,
        PoUIScaffold,
        PoUISvg,
        PoUIText;
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
  final RxBool _loading = RxBool(false);

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
    _loading.value = true;
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
          Expanded(
            child: BlocListener<PokemonBloc, PokemonState>(
              bloc: _bloc,
              listener: (_, PokemonState s) {
                if (s is PokemonListLoadingState) {
                  _loading.value = s.loading;
                } else if (s is PokemonListSuccessState) {
                  _data.addAll(s.data);
                  _refreshController.completeAll();
                } else if (s is PokemonListFailureState) {
                  // TODO: show toast
                  _refreshController.completeAll();
                }
              },
              child: _mainView(),
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

  Widget _mainView() => PoUIInfiniteListView(
    refresher: PoUIInfiniteListViewRefresh(
      controller: _refreshController,
      enablePullDown: !_loading.value,
      enablePullUp: !_loading.value,
      onRefresh: _refresh,
      onLoading: () => _bloc.add(PokemonListEvent(offset: _data.length)),
    ),
    headers: const <Widget>[
      SliverAppBar(
        backgroundColor: Colors.transparent,
        floating: true,
        pinned: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: PoUIText('Pokedex', fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
    ],
    children: <Widget>[],
  );
}
