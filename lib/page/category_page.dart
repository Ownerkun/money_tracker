import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_item.dart';
import 'package:graduation_project_app/page/category_add_page.dart';
import 'package:graduation_project_app/util/list/category_list.dart';
import 'package:flutter/cupertino.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryType _selectedType = CategoryType.income;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddNewCategory(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Text('Category Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ToggleButtons(
                    renderBorder: false,
                    constraints:
                        BoxConstraints.expand(width: constraints.maxWidth / 2),
                    isSelected: [
                      _selectedType == CategoryType.income,
                      _selectedType == CategoryType.expense,
                    ],
                    onPressed: (index) {
                      setState(() {
                        _selectedType = index == 0
                            ? CategoryType.income
                            : CategoryType.expense;
                      });
                    },
                    children: const [
                      Text('Income'),
                      Text('Expense'),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: CategoryList(categoryType: _selectedType),
            ),
          ],
        ),
      ),
    );
  }
}
