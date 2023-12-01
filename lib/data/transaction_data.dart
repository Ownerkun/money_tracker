class Transaction {
  final DateTime dateTime;
  final String description;
  final double amount;

  Transaction({
    required this.dateTime,
    required this.description,
    required this.amount,
  });

  static List<Transaction> transactions = [
    Transaction(
      dateTime: DateTime.now(),
      description: 'Groceriessss',
      amount: -50.0,
    ),
    Transaction(
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      description: 'Salary',
      amount: 2000.0,
    ),
    Transaction(
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Dinner',
      amount: -30.0,
    ),
  ];
}
