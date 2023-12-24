import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:provider/provider.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionData transactionData = Provider.of<TransactionData>(context);

    double totalExpense =
        transactionData.getTotalAmountByType(TransactionType.expense);
    return Expanded(
      child: SizedBox(
        height: 100,
        child: Card(
          // shadowColor: Colors.grey,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: Text(
                  totalExpense > 0
                      ? totalExpense.toStringAsFixed(2) // Format as currency
                      : '0.0',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text(
                  'Expense',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
