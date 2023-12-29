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

  void updateCategory(CategoryItem updatedCategory) {
    removeCategory(updatedCategory.id);
    addNewCategory(updatedCategory);
    notifyListeners();
  }

  void removeCategory(String categoryId) {
    overallCategoryList.removeWhere((category) => category.id == categoryId);
    notifyListeners();
  }
}
