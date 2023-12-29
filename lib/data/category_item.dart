enum CategoryType { income, expense }

class CategoryItem {
  final String id;
  final String name;
  final CategoryType type;

  CategoryItem({
    required this.id,
    required this.name,
    required this.type,
  });
}
