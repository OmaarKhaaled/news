import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/home/screens/search_screen.dart';
import 'package:news/shared/app_bloc_observer.dart';
import 'package:news/shared/constants/app_theme.dart';
import 'package:news/home/screens/home_screen.dart';


void main() {
  Bloc.observer = AppBlocObserver();
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SearchScreen.routeName: (_) => SearchScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
