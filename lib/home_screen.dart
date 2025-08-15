import 'package:flutter/material.dart';
import 'package:news/categories/categories_view.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: CategoriesView(),
    );
  }
}
