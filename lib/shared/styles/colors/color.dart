import 'dart:ui' show Color;

import 'package:flutter/material.dart' show Alignment, LinearGradient;

part 'color_base.dart';

abstract mixin class PoColor {
  PoColorBase get softCoral => const Color(0xFFF1696A).base;

  PoColorBase get goldenYellow => const Color(0xFFF5D06C).base;

  PoColorBase get mintTeal => const Color(0xFF46C8AA).base;

  PoColorBase get scaffold => const Color(0xFFF4F4F4).base;

  PoColorBase get text => const Color(0xFF313842).base;

  PoColorBase get textInvert => const Color(0xFFF4F4F4).base;

  static PoColor get get => _AppColor();
}

class _AppColor extends PoColor {}
