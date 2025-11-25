import 'package:flutter/material.dart';
import 'package:news/models/categry_model.dart';

class CategoryItem extends StatelessWidget {
  CategryModel categry;

  CategoryItem({super.key, required this.categry});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/${categry.imageName}.png',
        height: MediaQuery.sizeOf(context).height * .25,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
