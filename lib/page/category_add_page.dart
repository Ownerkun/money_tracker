import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_data.dart';
import 'package:graduation_project_app/data/category_item.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddCategory extends StatefulWidget {
  final CategoryType selectedType;
  final CategoryItem? categoryToEdit;

  const AddCategory({
    super.key,
    required this.selectedType,
    this.categoryToEdit,
  });

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  CategoryType _selectedType = CategoryType.income;
  String _categoryId = '';
  String _categoryName = '';

  @override
  void initState() {
    super.initState();
    _selectedType = widget.selectedType;

    if (widget.categoryToEdit != null) {
      _categoryId = widget.categoryToEdit!.id;
      _categoryName = widget.categoryToEdit!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.categoryToEdit != null ? 'Edit Category' : 'Add Category'),
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
              initialValue: _categoryName,
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
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {
                    save();
                  },
                  child: const Text('Save Category'),
                ),
                Visibility(
                  visible: widget.categoryToEdit != null,
                  child: ElevatedButton(
                    onPressed: () {
                      // Show a confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Category"),
                            content: const Text(
                                "Are you sure you want to delete this category?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Delete the transaction and close the dialog
                                  deleteCategory();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Delete"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    if (widget.categoryToEdit == null) {
      _categoryId = const Uuid().v4();
    }
    CategoryItem newCategory =
        CategoryItem(id: _categoryId, name: _categoryName, type: _selectedType);

    if (widget.categoryToEdit != null) {
      // Editing mode, update existing transaction
      Provider.of<CategoryData>(context, listen: false)
          .updateCategory(newCategory);
    } else {
      // Adding mode, add a new transaction
      Provider.of<CategoryData>(context, listen: false)
          .addNewCategory(newCategory);
    }

    Future.delayed(Duration.zero, () {
      Navigator.pop(context);
    });
  }

  void deleteCategory() {
    if (widget.categoryToEdit != null) {
      // If it's an existing transaction, remove it
      Provider.of<CategoryData>(context, listen: false)
          .removeCategory(widget.categoryToEdit!.id);
      Navigator.pop(context); // Close the AddTransaction page
    }
  }

  void printToConsole(BuildContext context) {
    print('Category:');
    print('ID: $_categoryId');
    print('Name: $_categoryName');
    print('Category: $_selectedType');
    print('---');
  }
}
