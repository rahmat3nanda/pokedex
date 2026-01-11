import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart'
    show MaterialPageRoute, Navigator, Route, Widget;
import 'package:pokedex/cores/core/context.manager.dart' show ContextManager;

part 'page_route/cupertino.no_swipe.page_route.dart';
part 'page_route/material.no_swipe.page_route.dart';

class PoNavigate {
  static Route<T> _build<T>(Widget page, {bool dismissible = true}) {
    if (dismissible) {
      return MaterialPageRoute<T>(builder: (_) => page);
    }

    if (Platform.isIOS) {
      return CupertinoNoSwipePageRoute<T>(builder: (_) => page);
    }

    return MaterialNoSwipePageRoute<T>(builder: (_) => page);
  }

  static Future<T?> to<T>(Widget page, {bool dismissible = true}) =>
      Navigator.of(
        ContextManager.i.context!,
      ).push(_build<T>(page, dismissible: dismissible));

  static Future<T?> move<T>(Widget page, {bool dismissible = true}) =>
      Navigator.of(
        ContextManager.i.context!,
      ).pushReplacement(_build<T>(page, dismissible: dismissible));

  static void backToRoot() => Navigator.of(
    ContextManager.i.context!,
  ).popUntil((Route<dynamic> route) => route.isFirst);
}
