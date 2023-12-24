import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_data.dart';
import 'package:graduation_project_app/data/category_item.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddTransaction extends StatefulWidget {
  final TransactionItem? transactionToEdit;

  const AddTransaction({Key? key, this.transactionToEdit}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String _transactionId = '';
  DateTime _selectedDateTime = DateTime.now();
  String? _selectedCategory;
  double _amount = 0.0;
  String _note = '';
  TransactionType _transactionType = TransactionType.expense;

  final _formKey = GlobalKey<FormState>();
  bool _saveButtonTapped = false;

  @override
  void initState() {
    super.initState();
    if (widget.transactionToEdit != null) {
      _transactionId = widget.transactionToEdit!.id;
      _selectedDateTime = widget.transactionToEdit!.dateTime;
      _selectedCategory = widget.transactionToEdit!.category;
      _amount = widget.transactionToEdit!.amount;
      _note = widget.transactionToEdit!.note;
      _transactionType = widget.transactionToEdit!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transactionToEdit != null
            ? 'Edit Transaction'
            : 'Add Transaction'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Debug

                // Text(
                //   'Transaction Id: $_transactionId',
                //   style: const TextStyle(fontSize: 16.0),
                // ),
                // Text(
                //   'Selected DateTime: ${DateFormat('MM/dd/yyyy HH:mm').format(_selectedDateTime)}',
                //   style: const TextStyle(fontSize: 16.0),
                // ),
                // Text(
                //   'Selected Category: $_selectedCategory',
                //   style: const TextStyle(fontSize: 16.0),
                // ),
                // Text(
                //   'Amount: $_amount',
                //   style: const TextStyle(fontSize: 16.0),
                // ),
                // Text(
                //   'Note: $_note',
                //   style: const TextStyle(fontSize: 16.0),
                // ),
                // Text(
                //   'Transaction Type: $_transactionType',
                //   style: const TextStyle(fontSize: 16.0),
                // ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Text(
                          'Date: ${DateFormat('MM/dd/yyyy').format(_selectedDateTime)}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: Text(
                          'Time: ${DateFormat('HH:mm').format(_selectedDateTime)}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ToggleButtons(
                        renderBorder: false,
                        constraints: BoxConstraints.expand(
                            width: constraints.maxWidth / 2),
                        isSelected: [
                          _transactionType == TransactionType.income,
                          _transactionType == TransactionType.expense,
                        ],
                        onPressed: (index) {
                          setState(() {
                            _transactionType = index == 0
                                ? TransactionType.income
                                : TransactionType.expense;
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
                ListTile(
                  title: const Text('Category'),
                  subtitle: _buildCategoryDropdown(context),
                ),
                ListTile(
                  title: const Text('Amout'),
                  subtitle: TextFormField(
                    initialValue: _amount == 0.0 ? null : _amount.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _amount = double.tryParse(value) ?? 0.0;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Amount',
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Note'),
                  subtitle: TextFormField(
                    initialValue: _note,
                    onChanged: (value) {
                      setState(() {
                        _note = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Note',
                    ),
                  ),
                ),
                if (_saveButtonTapped &&
                    (_formKey.currentState?.validate() == false ||
                        _selectedCategory == null))
                  const Text(
                    'Please fill in Category fields.',
                    style: TextStyle(color: Colors.red),
                  ),
                Wrap(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(),
                      onPressed: () {
                        // Set _saveButtonTapped to true when save button is tapped
                        setState(() {
                          _saveButtonTapped = true;
                        });

                        // Validate the form and category
                        if (_formKey.currentState?.validate() == true &&
                            _selectedCategory != null) {
                          save();
                        }
                      },
                      child: Text(
                        widget.transactionToEdit != null ? 'Save Edit' : 'Save',
                      ),
                    ),
                    Visibility(
                      visible: widget.transactionToEdit != null,
                      child: ElevatedButton(
                        onPressed: () {
                          // Show a confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Transaction"),
                                content: const Text(
                                    "Are you sure you want to delete this transaction?"),
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
                                      deleteTransaction();
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
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(BuildContext context) {
    CategoryData categoryData = Provider.of<CategoryData>(context);

    List<CategoryItem> categories = _getCategoriesByType(categoryData);

    return DropdownButtonFormField(
      value: _selectedCategory,
      onChanged: (value) {
        setState(() {
          _selectedCategory = value.toString();
        });
      },
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category.name,
          child: Text(category.name),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Select Category',
      ),
    );
  }

  List<CategoryItem> _getCategoriesByType(CategoryData categoryData) {
    List<CategoryItem> categories = categoryData.getAllCategoriesByType(
      _transactionType == TransactionType.income
          ? CategoryType.income
          : CategoryType.expense,
    );

    if (_selectedCategory != null) {
      // Check if the selected category is in the new set of categories
      bool categoryExists =
          categories.any((category) => category.name == _selectedCategory);

      if (!categoryExists) {
        // If not, default to selecting the first category in the new set
        _selectedCategory = categories.isNotEmpty ? categories[0].name : null;
      }
    }

    return categories;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDateTime) {
      setState(() {
        _selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );

    if (pickedTime != null && pickedTime != _selectedDateTime) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void save() {
    if (widget.transactionToEdit == null) {
      _transactionId = const Uuid().v4();
    }
    TransactionItem newTransaction = TransactionItem(
      id: _transactionId,
      dateTime: _selectedDateTime,
      category: _selectedCategory.toString(),
      amount: _amount,
      note: _note,
      type: _transactionType,
    );

    if (widget.transactionToEdit != null) {
      // Editing mode, update existing transaction
      Provider.of<TransactionData>(context, listen: false)
          .updateTransaction(newTransaction);
    } else {
      // Adding mode, add a new transaction
      Provider.of<TransactionData>(context, listen: false)
          .addNewTransaction(newTransaction);
    }
    printTransactionsToConsole(context);

    Navigator.pop(context);
  }

  void deleteTransaction() {
    if (widget.transactionToEdit != null) {
      // If it's an existing transaction, remove it
      Provider.of<TransactionData>(context, listen: false)
          .removeTransaction(widget.transactionToEdit!.id);
      Navigator.pop(context); // Close the AddTransaction page
    }
  }

  void printTransactionsToConsole(BuildContext context) {
    // Access the TransactionData provider
    TransactionData transactionData =
        Provider.of<TransactionData>(context, listen: false);

    // Print all transactions to console
    print('All Transactions:');
    transactionData.getAllTransaction().forEach((transaction) {
      print('Date: ${transaction.id}');
      print('Date: ${transaction.dateTime}');
      print('Category: ${transaction.category}');
      print('Amount: ${transaction.amount}');
      print('Note: ${transaction.note}');
      print('type: ${transaction.type}');
      print('---');
    });
  }
}
