import 'package:flutter/material.dart'
    show
        BuildContext,
        EdgeInsets,
        GlobalKey,
        MediaQuery,
        NavigatorState,
        OverlayState,
        Size;

class ContextManager {
  factory ContextManager() => _instance;

  ContextManager._();

  static final ContextManager _instance = ContextManager._();

  static ContextManager get i => _instance;

  final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

  BuildContext? get context => appKey.currentState?.context;

  OverlayState? get overlay => appKey.currentState?.overlay;

  BuildContext? get overlayContext => appKey.currentState?.overlay?.context;

  EdgeInsets? get padding =>
      context == null ? null : MediaQuery.of(context!).padding;

  EdgeInsets? get viewInsets =>
      context == null ? null : MediaQuery.of(context!).viewInsets;

  Size? get size => context == null ? null : MediaQuery.of(context!).size;
}
