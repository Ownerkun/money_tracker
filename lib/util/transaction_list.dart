import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/util/transaction_tile.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Transaction.transactions.length,
      itemBuilder: (context, index) {
        return TransactionTile(transaction: Transaction.transactions[index]);
      },
    );
  }
}
