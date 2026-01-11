import 'package:flutter/material.dart'
    show
        FontWeight,
        StatelessWidget,
        Text,
        TextAlign,
        TextOverflow,
        TextStyle,
        Widget;
import 'package:pokedex/shared/styles/colors/color.dart'
    show PoColor, PoColorBase;

class PoUIText extends StatelessWidget {
  const PoUIText(
    this.text, {
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    super.key,
  });

  final String text;
  final TextAlign? textAlign;
  final PoColorBase? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(_) => Text(
    text,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      color: color?.value ?? PoColor.get.text.value,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    textAlign: textAlign,
  );
}
