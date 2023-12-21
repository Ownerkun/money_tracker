import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:provider/provider.dart';

class Balancetile extends StatelessWidget {
  const Balancetile({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionData transactionData = Provider.of<TransactionData>(context);

    double balance =
        transactionData.getTotalAmountByType(TransactionType.income) -
            transactionData.getTotalAmountByType(TransactionType.expense);
    return Expanded(
      child: SizedBox(
        height: 150,
        child: Card(
          shadowColor: Colors.grey,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                balance != 0.0 ? balance.toStringAsFixed(2) : '0.0',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                'Balance',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
