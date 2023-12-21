import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:graduation_project_app/page/transaction_add_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    List<TransactionItem> transactions =
        Provider.of<TransactionData>(context).getAllTransaction();

    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'No Data',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    Map<String, List<TransactionItem>> groupedTransactions =
        groupTransactionsByDate(transactions);

    return ListView.builder(
      itemCount: groupedTransactions.length,
      itemBuilder: (context, index) {
        String date = groupedTransactions.keys.elementAt(index);
        List<TransactionItem> transactionsOnDate = groupedTransactions[date]!;
        bool isLastList = index == groupedTransactions.length - 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('MMMM d, yyyy')
                    .format(transactionsOnDate.first.dateTime),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...transactionsOnDate.map((TransactionItem transaction) {
              Color textColor = Colors.black;
              if (transaction.type == TransactionType.income) {
                textColor = Colors.green;
              } else if (transaction.type == TransactionType.expense) {
                textColor = Colors.red;
              }
              return ListTile(
                onTap: () {
                  printTransactionsToConsole(transaction);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTransaction(
                        transactionToEdit: transaction,
                      ),
                    ),
                  );
                },
                title: Text(
                  transaction.category,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle:
                    Text(DateFormat('HH:mm:ss').format(transaction.dateTime)),
                trailing: Text(
                  NumberFormat.currency(
                    symbol: '',
                    decimalDigits: 2,
                  ).format(transaction.amount),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              );
            }).toList(),
            if (isLastList) const SizedBox(height: 50),
          ],
        );
      },
    );
  }

  Map<String, List<TransactionItem>> groupTransactionsByDate(
      List<TransactionItem> transactions) {
    Map<String, List<TransactionItem>> groupedTransactions = {};

    for (TransactionItem transaction in transactions) {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(transaction.dateTime);
      if (!groupedTransactions.containsKey(formattedDate)) {
        groupedTransactions[formattedDate] = [];
      }
      groupedTransactions[formattedDate]!.add(transaction);
    }

    return groupedTransactions;
  }

  void printTransactionsToConsole(TransactionItem transaction) {
    // Print details of the specific transaction to console
    print('Transaction Details:');
    print('Date: ${transaction.dateTime}');
    print('Category: ${transaction.category}');
    print('Amount: ${transaction.amount}');
    print('Note: ${transaction.note}');
    print('Type: ${transaction.type}');
    print('---');
  }
}
