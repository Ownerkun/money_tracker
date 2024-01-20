import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/data/transaction_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeTile extends StatefulWidget {
  const IncomeTile({super.key});

  @override
  State<IncomeTile> createState() => _IncomeTileState();
}

class _IncomeTileState extends State<IncomeTile> {
  @override
  void initState() {
    super.initState();

    Provider.of<TransactionData>(context, listen: false).prepareData();
  }

  @override
  Widget build(BuildContext context) {
    TransactionData transactionData = Provider.of<TransactionData>(context);

    double totalIncome =
        transactionData.getTotalAmountByType(TransactionType.income);

    return Expanded(
      child: SizedBox(
        height: 100,
        child: Card(
          // shadowColor: Colors.grey,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    totalIncome > 0
                        ? NumberFormat.currency(
                            symbol: '',
                            decimalDigits: 2,
                          ).format(totalIncome)
                        : '0.0',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                subtitle: const Text(
                  'Income',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
