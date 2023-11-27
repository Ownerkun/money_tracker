import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: Card(
          shadowColor: Colors.grey,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.attach_money_rounded),
                title: Text('500,000.00'),
                subtitle: Text('Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
