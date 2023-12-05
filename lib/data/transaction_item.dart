class TransactionItem {
  final DateTime dateTime;
  final String category;
  final double amount;
  final String note;

  TransactionItem(
      {required this.dateTime,
      required this.category,
      required this.amount,
      required this.note});
}
