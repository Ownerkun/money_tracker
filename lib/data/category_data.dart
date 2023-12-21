import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_item.dart';

class CategoryData extends ChangeNotifier {
  List<CategoryItem> overallCategoryList = [];

  List<CategoryItem> getAllCategoriesByType(CategoryType type) {
    return overallCategoryList
        .where((category) => category.type == type)
        .toList();
  }

  void addNewCategory(CategoryItem newCategory) {
    overallCategoryList.add(newCategory);
    notifyListeners();
  }
}
