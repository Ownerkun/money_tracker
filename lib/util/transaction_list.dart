import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions =
        Provider.of<TransactionData>(context).getAllTransaction();
    return transactions.isEmpty
        ? const Center(
            child: Text('No data'),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(transactions[index].category),
                // subtitle: Text(${transactions[index].dateTime.toString()}),
                subtitle: Text(DateFormat('dd/MM/yyyy HH:mm:ss')
                    .format(transactions[index].dateTime)),
                trailing: Text(transactions[index].amount.toString()),
              );
            },
          );
  }
}
