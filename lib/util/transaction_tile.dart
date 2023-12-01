import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.description),
      subtitle: Text(transaction.dateTime.toString()),
      trailing: Text(transaction.amount.toString()),
    );
  }
}
