import 'package:flutter/material.dart'
    show
        Axis,
        BuildContext,
        CustomScrollView,
        EdgeInsets,
        EdgeInsetsGeometry,
        GlobalKey,
        KeyedSubtree,
        MediaQuery,
        MediaQueryData,
        ScrollController,
        ScrollPhysics,
        SliverChildBuilderDelegate,
        SliverList,
        SliverPadding,
        SliverToBoxAdapter,
        State,
        StatefulWidget,
        StatelessWidget,
        VoidCallback,
        Widget;
import 'package:pokedex/shared/ui/extensions/widget.sliver.dart'
    show WidgetSliver;
import 'package:pull_to_refresh/pull_to_refresh.dart'
    show RefreshController, SmartRefresher;

class PoUIInfiniteListView extends StatefulWidget {
  const PoUIInfiniteListView({
    required this.children,
    this.childrenKey,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.reverse = false,
    this.shrinkWrap = false,
    this.primary,
    this.cacheExtent,
    this.padding,
    this.headers,
    this.footers,
    this.refresher,
    this.enableRefresher = true,
    this.removeTop = false,
    super.key,
  });

  factory PoUIInfiniteListView.builder({
    required int itemCount,
    required Widget Function(int index) itemBuilder,
    ScrollController? scrollController,
    Axis scrollDirection = Axis.vertical,
    ScrollPhysics? physics,
    bool reverse = false,
    bool shrinkWrap = false,
    bool? primary,
    double? cacheExtent,
    EdgeInsets? padding,
    List<Widget>? headers,
    List<Widget>? footers,
    PoUIInfiniteListViewRefresh? refresher,
    bool enableRefresher = true,
    bool removeTop = false,
  }) => PoUIInfiniteListView(
    scrollController: scrollController,
    scrollDirection: scrollDirection,
    physics: physics,
    reverse: reverse,
    shrinkWrap: shrinkWrap,
    primary: primary,
    cacheExtent: cacheExtent,
    padding: padding,
    headers: headers,
    footers: footers,
    refresher: refresher,
    enableRefresher: enableRefresher,
    removeTop: removeTop,
    children: List<Widget>.generate(itemCount, itemBuilder),
  );

  factory PoUIInfiniteListView.separated({
    required int itemCount,
    required Widget Function(int index) itemBuilder,
    required Widget Function(int index) separatorBuilder,
    ScrollController? scrollController,
    Axis scrollDirection = Axis.vertical,
    ScrollPhysics? physics,
    bool reverse = false,
    bool shrinkWrap = false,
    bool? primary,
    double? cacheExtent,
    EdgeInsets? padding,
    List<Widget>? headers,
    List<Widget>? footers,
    PoUIInfiniteListViewRefresh? refresher,
    bool enableRefresher = true,
    bool removeTop = false,
  }) => PoUIInfiniteListView(
    scrollController: scrollController,
    scrollDirection: scrollDirection,
    physics: physics,
    reverse: reverse,
    shrinkWrap: shrinkWrap,
    primary: primary,
    cacheExtent: cacheExtent,
    padding: padding,
    headers: headers,
    footers: footers,
    refresher: refresher,
    enableRefresher: enableRefresher,
    removeTop: removeTop,
    children: itemCount <= 0
        ? <Widget>[]
        : List<Widget>.generate(
            itemCount * 2 - 1,
            (int index) => index.isEven
                ? itemBuilder(index ~/ 2)
                : separatorBuilder(index ~/ 2),
          ),
  );

  final List<Widget> children;
  final GlobalKey? childrenKey;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool reverse;
  final bool shrinkWrap;
  final bool? primary;
  final double? cacheExtent;
  final EdgeInsets? padding;
  final List<Widget>? headers;
  final List<Widget>? footers;

  final PoUIInfiniteListViewRefresh? refresher;
  final bool enableRefresher;
  final bool removeTop;

  @override
  State<PoUIInfiniteListView> createState() => _PoUIInfiniteListViewState();
}

class _PoUIInfiniteListViewState extends State<PoUIInfiniteListView> {
  late final RefreshController controller =
      widget.refresher?.controller ?? RefreshController();

  @override
  void dispose() {
    if (widget.refresher?.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.enableRefresher
      ? SmartRefresher(
          controller: controller,
          onRefresh: widget.refresher?.onRefresh,
          onLoading: widget.refresher?.onLoading,
          enablePullUp: widget.refresher?.enablePullUp ?? false,
          enablePullDown: widget.refresher?.enablePullDown ?? false,
          header: widget.refresher?.header,
          footer: widget.refresher?.footer,
          child: _mainView(),
        )
      : _mainView();

  Widget _mainView() => CustomScrollView(
    controller: widget.scrollController,
    scrollDirection: widget.scrollDirection,
    physics: widget.physics,
    reverse: widget.reverse,
    shrinkWrap: widget.shrinkWrap,
    primary: widget.primary,
    cacheExtent: widget.cacheExtent,
    slivers: <Widget>[
      ...(widget.headers ?? <Widget>[]).map(
        (Widget item) => item.isSliver ? item : SliverToBoxAdapter(child: item),
      ),
      _ContextualSliverPadding(
        padding: widget.padding,
        scrollDirection: widget.scrollDirection,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: widget.children.length,
            (_, int index) => index == 0 && widget.childrenKey != null
                ? KeyedSubtree(
                    key: widget.childrenKey,
                    child: widget.children[index],
                  )
                : widget.children[index],
          ),
        ),
      ),
      ...(widget.footers ?? <Widget>[]).map(
        (Widget item) => item.isSliver ? item : SliverToBoxAdapter(child: item),
      ),
    ],
  );
}

class _ContextualSliverPadding extends StatelessWidget {
  const _ContextualSliverPadding({
    required this.scrollDirection,
    required this.sliver,
    this.padding,
  });

  final EdgeInsets? padding;
  final Axis scrollDirection;
  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry? effectivePadding = padding;
    final MediaQueryData? mediaQuery = MediaQuery.maybeOf(context);

    Widget sliver = this.sliver;
    if (padding == null) {
      if (mediaQuery != null) {
        late final EdgeInsets mediaQueryHorizontalPadding = mediaQuery.padding
            .copyWith(top: 0, bottom: 0);
        late final EdgeInsets mediaQueryVerticalPadding = mediaQuery.padding
            .copyWith(left: 0, right: 0);
        effectivePadding = scrollDirection == Axis.vertical
            ? mediaQueryVerticalPadding
            : mediaQueryHorizontalPadding;
        sliver = MediaQuery(
          data: mediaQuery.copyWith(
            padding: scrollDirection == Axis.vertical
                ? mediaQueryHorizontalPadding
                : mediaQueryVerticalPadding,
          ),
          child: sliver,
        );
      }
    }

    if (effectivePadding != null) {
      sliver = SliverPadding(padding: effectivePadding, sliver: sliver);
    }
    return sliver;
  }
}

class PoUIInfiniteListViewRefresh {
  PoUIInfiniteListViewRefresh({
    this.controller,
    this.enablePullUp = false,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoading,
    this.header,
    this.footer,
  });

  final PoRefreshController? controller;
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget? header;
  final Widget? footer;
}

typedef PoRefreshController = RefreshController;

extension PoRefreshControllerExtension on PoRefreshController {
  void completeAll() {
    refreshCompleted();
    loadComplete();
  }
}
