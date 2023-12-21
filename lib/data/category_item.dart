enum CategoryType { income, expense }

class CategoryItem {
  final String name;
  final CategoryType type;

  CategoryItem({
    required this.name,
    required this.type,
  });
}
