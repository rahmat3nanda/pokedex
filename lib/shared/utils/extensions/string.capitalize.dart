extension StringCapitalize on String? {
  String get capitalize {
    final String s = this ?? '';
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
