import 'package:flutter/material.dart'
    show
        AnnotatedRegion,
        Brightness,
        Colors,
        MaterialApp,
        StatelessWidget,
        Widget;
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:pokedex/app/pages/home.page.dart' show HomePage;
import 'package:pokedex/shared/styles/theme_data.dart' show poThemeData;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(_) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: poThemeData,
      home: const HomePage(),
    ),
  );
}
