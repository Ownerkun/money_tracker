import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/page/transaction_add_page.dart';
import 'package:graduation_project_app/util/tile/balance_tile.dart';
import 'package:graduation_project_app/util/tile/expense_tile.dart';
import 'package:graduation_project_app/util/tile/income_tile.dart';
import 'package:graduation_project_app/util/list/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<TransactionData>(context, listen: false).prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddTransaction(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: const Column(
        children: [
          Row(
            children: [
              Balancetile(),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              IncomeTile(),
              SizedBox(width: 16),
              ExpenseTile(),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: TransactionList(),
          ),
        ],
      ),
    );
  }
}
