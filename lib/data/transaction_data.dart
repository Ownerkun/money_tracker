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

  void updateTransaction(TransactionItem updatedTransaction) {
    int index = overallTransactionList.indexWhere(
        (transaction) => transaction.dateTime == updatedTransaction.dateTime);

    if (index != -1) {
      overallTransactionList.removeAt(index);
      overallTransactionList.add(updatedTransaction);
      notifyListeners();
    }
  }

  void removeTransaction(TransactionItem transaction) {
    overallTransactionList.remove(transaction);

    notifyListeners();
  }

  double getTotalAmountByType(TransactionType type) {
    double totalAmount = 0.0;

    for (TransactionItem transaction in overallTransactionList) {
      if (transaction.type == type) {
        totalAmount += transaction.amount;
      }
    }

    return totalAmount;
  }
}
