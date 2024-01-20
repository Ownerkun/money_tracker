import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:provider/provider.dart';

class CategoryGraph extends StatelessWidget {
  const CategoryGraph({super.key});

  @override
  Widget build(BuildContext context) {
    List<TransactionItem> transactions =
        Provider.of<TransactionData>(context).getAllTransaction();

    // Transform data for graphing
    Map<String, double> incomeCategoryAmounts = {};
    Map<String, double> expenseCategoryAmounts = {};

    for (TransactionItem transaction in transactions) {
      String category = transaction.category;
      double amount = transaction.amount;

      if (transaction.type == TransactionType.income) {
        incomeCategoryAmounts.update(category, (value) => value + amount,
            ifAbsent: () => amount);
      } else if (transaction.type == TransactionType.expense) {
        expenseCategoryAmounts.update(category, (value) => value + amount,
            ifAbsent: () => amount);
      }
    }

    // Convert data to series
    List<PieChartSectionData> incomeSections = incomeCategoryAmounts.entries
        .map(
          (entry) => PieChartSectionData(
            value: entry.value,
            title: entry.key,
            radius: 80,
          ),
        )
        .toList();

    List<PieChartSectionData> expenseSections = expenseCategoryAmounts.entries
        .map(
          (entry) => PieChartSectionData(
            value: entry.value,
            title: entry.key,
            radius: 80,
          ),
        )
        .toList();

    return Column(
      children: [
        PieChart(
          PieChartData(
            sections: incomeSections,
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
          ),
        ),
        PieChart(
          PieChartData(
            sections: expenseSections,
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
          ),
        ),
      ],
    );
  }
}
