import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime _selectedDateTime = DateTime.now();
  String? _selectedCategory;
  double _amount = 0.0;
  String _note = '';

  final List<String> _categories = ['Groceries', 'Salary', 'Dinner', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Time input
            GestureDetector(
              onTap: () => _selectDateTime(context),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: ${DateFormat('MM/dd/yyyy').format(_selectedDateTime)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Time: ${DateFormat('HH:mm').format(_selectedDateTime)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Category dropdown
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
            const SizedBox(height: 16.0),

            // Amount input
            ListTile(
              title: const Text('Amount'),
              subtitle: TextFormField(
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
            const SizedBox(height: 16.0),

            // Note input
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
            const SizedBox(height: 16.0),

            // Submit button
            ElevatedButton(
              onPressed: () {
                // Perform form submission or save data to the database
                // You can use the _selectedDateTime, _selectedCategory, _amount, and _note variables here
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDateTime = selectedDateTime;
        });
      }
    }
  }
}
