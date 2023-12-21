import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_data.dart';
import 'package:graduation_project_app/data/category_item.dart';
import 'package:provider/provider.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  CategoryType _selectedType = CategoryType.income;
  String _categoryName = '';

  @override
  Widget build(BuildContext context) {
    CategoryData categoryData = Provider.of<CategoryData>(context);

    return Scaffold(
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
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _categoryName = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Enter Category Name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                categoryData.addNewCategory(
                  CategoryItem(name: _categoryName, type: _selectedType),
                );
                Navigator.pop(context);
              },
              child: const Text('Save Category'),
            ),
          ],
        ),
      ),
    );
  }
}
