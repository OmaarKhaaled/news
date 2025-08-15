import 'package:flutter/material.dart';
import 'package:news/categories/category_item.dart';
import 'package:news/models/categry_model.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, right: 12, left: 12),
      child: Column(
        children: [
          Text(
            'Good Morning\nHere is Some News For You',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) => GestureDetector(
                child: CategoryItem(categry: CategryModel.categories[index]),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: CategryModel.categories.length,
              padding: EdgeInsets.only(top: 16),
            ),
          ),
        ],
      ),
    );
  }
}
