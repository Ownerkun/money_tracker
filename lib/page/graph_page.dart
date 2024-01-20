import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_project_app/data/category_item.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  double totalAmount = 0.0;
  Map<String, double> categoryTotal = {};

  CategoryType _selectedType = CategoryType.expense;

  @override
  void initState() {
    super.initState();
    calculateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graph'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ToggleButtons(
                    renderBorder: false,
                    constraints:
                        BoxConstraints.expand(width: constraints.maxWidth / 2),
                    isSelected: [
                      _selectedType == CategoryType.income,
                      _selectedType == CategoryType.expense,
                    ],
                    onPressed: (index) {
                      setState(() {
                        _selectedType = index == 0
                            ? CategoryType.income
                            : CategoryType.expense;
                        calculateData();
                      });
                    },
                    children: const [
                      Text('Income'),
                      Text('Expense'),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: buildCategoryChart(),
          ),
          Expanded(
            flex: 1,
            child: buildCategoryList(),
          ),
        ],
      ),
    );
  }

  void calculateData() {
    // Get transactions to build the chart and list
    List<TransactionItem> transactions =
        Provider.of<TransactionData>(context, listen: false)
            .getAllTransaction();

    // Filter transactions based on the selected category type
    transactions = transactions
        .where((transaction) => _selectedType == CategoryType.income
            ? transaction.type == TransactionType.income
            : transaction.type == TransactionType.expense)
        .toList();

    // Calculate total amount spent for all categories
    totalAmount = transactions.fold(0.0,
        (double sum, TransactionItem transaction) => sum + transaction.amount);

    // Calculate total amount spent for each category, excluding categories with amount = 0
    categoryTotal = {};
    for (TransactionItem transaction in transactions) {
      String category = transaction.category;
      double amount = transaction.amount;

      // Only add to the categoryTotal if the amount is greater than 0
      if (amount > 0) {
        categoryTotal[category] = (categoryTotal[category] ?? 0) + amount;
      }
    }
  }

  List<Color> sectionColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lime,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.redAccent,
    // Add more colors as needed
  ];

  Widget buildCategoryChart() {
    // Convert data to PieChart format
    List<MapEntry<String, double>> sortedEntries = categoryTotal.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sortedEntries.isEmpty) {
      return const Center(child: Text('No Data'));
    }

    List<PieChartSectionData> sections =
        sortedEntries.asMap().entries.map((mapEntry) {
      int index = mapEntry.key;
      MapEntry<String, double> entry = mapEntry.value;

      double percentage = (entry.value / totalAmount) * 100;

      return PieChartSectionData(
        value: percentage,
        title: '',
        radius: 100,
        color: sectionColors[index % sectionColors.length],
        badgeWidget: buildCalloutLabel(entry.key, percentage),
        badgePositionPercentageOffset: 1,
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sectionsSpace: 4,
          centerSpaceRadius: 20,
          sections: sections,
        ),
        swapAnimationCurve: decelerateEasing,
        swapAnimationDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget buildCategoryList() {
    List<MapEntry<String, double>> sortedEntries = categoryTotal.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sortedEntries.isEmpty) {
      return const Center(
        child: Text('No Data'),
      );
    }

    return ListView.builder(
      itemCount: sortedEntries.length,
      itemBuilder: (context, index) {
        String category = sortedEntries[index].key;
        double categoryAmount = sortedEntries[index].value;
        double percentage = (categoryAmount / totalAmount) * 100;

        return ListTile(
          leading: Card(
            color: sectionColors[index],
            child: SizedBox(
              width: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          title: Text(
            category,
            style: const TextStyle(fontSize: 14),
          ),
          trailing: Text(
            NumberFormat.currency(
              symbol: '',
              decimalDigits: 2,
            ).format(categoryAmount),
          ),
        );
      },
    );
  }

  Widget buildCalloutLabel(String category, double percentage) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).splashColor,
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${percentage.toStringAsFixed(2)}%',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
