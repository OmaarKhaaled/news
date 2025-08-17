import 'package:flutter/material.dart';
import 'package:news/Drawer/home_drawer.dart';
import 'package:news/categories/categories_view.dart';
import 'package:news/models/categry_model.dart';
import 'package:news/news/news_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategryModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory == null ? 'Home' : selectedCategory!.name),
      ),
      drawer: HomeDrawer(onGpToHomeClicked: resetSelectedCategory),
      body: selectedCategory == null
          ? CategoriesView(onCategorySelected: onCategorySelected)
          : NewsView(categoryId: selectedCategory!.id),
    );
  }

  void onCategorySelected(CategryModel category) {
    selectedCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }
}
