import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/home/screens/search_screen.dart';
import 'package:news/home/widgets/home_drawer.dart';
import 'package:news/categories/view/widgets/categories_view.dart';
import 'package:news/models/categry_model.dart';
import 'package:news/news/view/widgets/news_view.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/sources/view_model/sources_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => NewsViewModel()),
        BlocProvider(create: (_) => SourcesViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            selectedCategory == null ? 'Home' : selectedCategory!.name,
          ),
          actions: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, SearchScreen.routeName),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 18,
                  height: 18,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        drawer: HomeDrawer(onGoToHomeClicked: resetSelectedCategory),
        body: selectedCategory == null
            ? CategoriesView(onCategorySelected: onCategorySelected)
            : NewsView(categoryId: selectedCategory!.id),
      ),
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
