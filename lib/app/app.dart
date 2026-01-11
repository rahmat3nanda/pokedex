import 'package:flutter/material.dart'
    show
        AnnotatedRegion,
        Brightness,
        Colors,
        MaterialApp,
        StatelessWidget,
        Widget;
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart' show MultiBlocProvider;
import 'package:pokedex/app/app.provider.dart' show AppProvider;
import 'package:pokedex/app/pages/home.page.dart' show HomePage;
import 'package:pokedex/cores/core/context.manager.dart' show ContextManager;
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
    child: MultiBlocProvider(
      providers: AppProvider.list,
      child: MaterialApp(
        navigatorKey: ContextManager.i.appKey,
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: poThemeData,
        home: const HomePage(),
      ),
    ),
  );
}
