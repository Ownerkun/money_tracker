import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:graduation_project_app/database/hive_database.dart';

class TransactionData extends ChangeNotifier {
  List<TransactionItem> overallTransactionList = [];

  List<TransactionItem> getAllTransaction() {
    //sort transaction by dateTime
    overallTransactionList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return overallTransactionList;
  }

  final transactionDatabase = HiveDatabase();
  void prepareData() {
    if (transactionDatabase.readTransactionData().isNotEmpty) {
      overallTransactionList = transactionDatabase.readTransactionData();
    }
  }

  void addNewTransaction(TransactionItem newTransaction) {
    overallTransactionList.add(newTransaction);
    notifyListeners();
    transactionDatabase.saveTransactionData(overallTransactionList);
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
    transactionDatabase.saveTransactionData(overallTransactionList);
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
