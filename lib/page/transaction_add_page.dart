import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime _selectedDateTime = DateTime.now();
  String? _selectedCategory;
  double _amount = 0.0;
  String _note = '';

  final List<String> _categories = ['Groceries', 'Salary', 'Dinner', 'Other'];

  // text controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        elevation: 0,
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
            ListTile(
              title: const Text('Category'),
              subtitle: DropdownButtonFormField(
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value.toString();
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                ),
              ),
            ),
            ListTile(
              title: const Text('Amout'),
              subtitle: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _amount = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Amout',
                ),
              ),
            ),
            ListTile(
              title: const Text('Note'),
              subtitle: TextFormField(
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
            ElevatedButton(
              onPressed: () {
                save();
                printTransactionsToConsole(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
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
    // Implement your save logic here
    // print('Saving transaction:');
    // print('Date: $_selectedDateTime');
    // print(_selectedDateTime.runtimeType);
    // print('Category: $_selectedCategory');
    // print(_selectedCategory.runtimeType);
    // print('Amount: $_amount');
    // print(_amount.runtimeType);
    // print('Note: $_note');
    // print(_note.runtimeType);
    TransactionItem newTransaction = TransactionItem(
        dateTime: _selectedDateTime,
        category: _selectedCategory.toString(),
        amount: _amount,
        note: _note);

    Provider.of<TransactionData>(context, listen: false)
        .addNewTransaction(newTransaction);

    Navigator.pop(context);
  }

  void printTransactionsToConsole(BuildContext context) {
    // Access the TransactionData provider
    TransactionData transactionData =
        Provider.of<TransactionData>(context, listen: false);

    // Print all transactions to console
    print('All Transactions:');
    transactionData.getAllTransaction().forEach((transaction) {
      print('Date: ${transaction.dateTime}');
      print('Category: ${transaction.category}');
      print('Amount: ${transaction.amount}');
      print('Note: ${transaction.note}');
      print('---');
    });
  }
}
