enum TransactionType { income, expense }

class TransactionItem {
  final DateTime dateTime;
  final String category;
  final double amount;
  final String note;
  final TransactionType type;

  TransactionItem(
      {required this.dateTime,
      required this.category,
      required this.amount,
      required this.note,
      required this.type});
}
