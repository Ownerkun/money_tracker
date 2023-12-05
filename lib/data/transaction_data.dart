import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_item.dart';

class TransactionData extends ChangeNotifier {
  List<TransactionItem> overallTransactionList = [];

  List<TransactionItem> getAllTransaction() {
    overallTransactionList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return overallTransactionList;
  }

  void addNewTransaction(TransactionItem newTransaction) {
    overallTransactionList.add(newTransaction);

    notifyListeners();
  }

  void removeTransaction(TransactionItem transaction) {
    overallTransactionList.remove(transaction);

    notifyListeners();
  }
}
