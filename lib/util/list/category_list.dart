import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_data.dart';
import 'package:graduation_project_app/data/category_item.dart';
import 'package:graduation_project_app/page/category_add_page.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.categoryType});

  final CategoryType categoryType;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();

    Provider.of<CategoryData>(context, listen: false).prepareData();
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryItem> categories = Provider.of<CategoryData>(context)
        .getAllCategoriesByType(widget.categoryType);

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
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddCategory(
                          selectedType: category.type,
                          categoryToEdit: category,
                        )));
          },
          title: Text(
            category.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
