import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_data.dart';
import 'package:graduation_project_app/data/category_item.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key, required this.categoryType}) : super(key: key);

  final CategoryType categoryType;

  @override
  Widget build(BuildContext context) {
    List<CategoryItem> categories =
        Provider.of<CategoryData>(context).getAllCategoriesByType(categoryType);

    if (categories.isEmpty) {
      return const Center(
        child: Text(
          'No Data',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        CategoryItem category = categories[index];

        return ListTile(
          title: Text(
            category.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
