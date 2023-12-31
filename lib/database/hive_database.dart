import 'package:graduation_project_app/data/category_item.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  final _transactionBox = Hive.box('transaction_database');
  final _categoryBox = Hive.box('category_database');

  void saveTransactionData(List<TransactionItem> allTransaction) {
    List<List<dynamic>> allTransactionFormatted = [];
    for (var transaction in allTransaction) {
      List<dynamic> transactionFormatted = [
        transaction.id,
        transaction.dateTime,
        transaction.category,
        transaction.amount,
        transaction.note,
        transaction.type,
      ];
      allTransactionFormatted.add(transactionFormatted);
    }

    _transactionBox.put("ALL_TRANSACTION", allTransactionFormatted);
  }

  List<TransactionItem> readTransactionData() {
    List savedTransaction = _transactionBox.get("ALL_TRANSACTION") ?? [];
    List<TransactionItem> allTransaction = [];

    for (int i = 0; i < savedTransaction.length; i++) {
      String id = savedTransaction[i][0];
      DateTime dateTime = savedTransaction[i][1];
      String category = savedTransaction[i][2];
      double amount = savedTransaction[i][3];
      String note = savedTransaction[i][4];
      TransactionType type = savedTransaction[i][5];

      TransactionItem transaction = TransactionItem(
        id: id,
        dateTime: dateTime,
        category: category,
        amount: amount,
        note: note,
        type: type,
      );

      allTransaction.add(transaction);
    }

    return allTransaction;
  }

  void saveCategoryData(List<CategoryItem> allCategory) {
    List<List<dynamic>> allCategoryFormatted = [];
    for (var category in allCategory) {
      List<dynamic> categoryFormatted = [
        category.id,
        category.name,
        category.type,
      ];
      allCategoryFormatted.add(categoryFormatted);
    }
    _categoryBox.put("ALL_CATEGORY", allCategoryFormatted);
  }

  List<CategoryItem> readCategoryData() {
    List savedCategory = _categoryBox.get("ALL_CATEGORY") ?? [];
    List<CategoryItem> allCategory = [];

    for (int i = 0; i < savedCategory.length; i++) {
      String id = savedCategory[i][0];
      String name = savedCategory[i][1];
      CategoryType type = savedCategory[i][2];

      CategoryItem category = CategoryItem(
        id: id,
        name: name,
        type: type,
      );

      allCategory.add(category);
    }

    return allCategory;
  }
}
