import 'package:flutter/material.dart'
    show
        AppBarTheme,
        BorderRadius,
        BorderSide,
        ColorScheme,
        Colors,
        EdgeInsets,
        FontWeight,
        IconThemeData,
        InputDecorationTheme,
        OutlineInputBorder,
        TabBarThemeData,
        TextStyle,
        ThemeData;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:pokedex/shared/styles/colors/color.dart' show PoColor;

ThemeData get _themeData => ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: PoColor.get.softCoral.value),
  scaffoldBackgroundColor: PoColor.get.scaffold.value,
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.lato(),
    iconTheme: IconThemeData(color: PoColor.get.text.value),
  ),
  tabBarTheme: TabBarThemeData(
    labelStyle: GoogleFonts.lato(),
    unselectedLabelStyle: GoogleFonts.lato(),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: PoColor.get.goldenYellow.value,
    ),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: PoColor.get.softCoral.value),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  ),
);

ThemeData get poThemeData => _themeData.copyWith(
  textTheme: GoogleFonts.latoTextTheme(_themeData.textTheme),
);
