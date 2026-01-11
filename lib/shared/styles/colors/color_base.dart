part of 'color.dart';

typedef PoColorsBase = List<PoColorBase>;

class PoColorBase {
  const PoColorBase(this.value);

  final Color value;
}

extension _ColorPowColorBase on Color {
  PoColorBase get base => PoColorBase(this);
}

extension PowColorToolBase on PoColorBase {
  PoColorBase withOpacity(double opacity) =>
      PoColorBase(value.withValues(alpha: opacity));

  PoColorsBase toColors({int length = 2}) =>
      List<PoColorBase>.generate(length, (_) => this);
}

extension PoColorsToolBase on PoColorsBase {
  List<Color> get values => map((PoColorBase e) => e.value).toList();

  PoColorsBase withOpacity(double opacity) =>
      map((PoColorBase e) => e.withOpacity(opacity)).toList();

  LinearGradient gradient({
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) => LinearGradient(begin: begin, end: end, colors: values);
}
