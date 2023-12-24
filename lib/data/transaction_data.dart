import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_item.dart';

class TransactionData extends ChangeNotifier {
  List<TransactionItem> overallTransactionList = [];

  List<TransactionItem> getAllTransaction() {
    //sort transaction by dateTime
    overallTransactionList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return overallTransactionList;
  }

  void addNewTransaction(TransactionItem newTransaction) {
    overallTransactionList.add(newTransaction);
    notifyListeners();
  }

  void updateTransaction(TransactionItem updatedTransaction) {
    removeTransaction(updatedTransaction.id);
    addNewTransaction(updatedTransaction);
    notifyListeners();
  }

  void removeTransaction(String transactionId) {
    overallTransactionList
        .removeWhere((transaction) => transaction.id == transactionId);
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
