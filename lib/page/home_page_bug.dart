import 'package:flutter/material.dart';
import 'package:graduation_project_app/page/test_add_transaction.dart';
import 'package:graduation_project_app/util/balance_tile.dart';
import 'package:graduation_project_app/util/expense_tile.dart';
import 'package:graduation_project_app/util/income_tile.dart';
import 'package:graduation_project_app/page/transaction_add_page.dart';
import 'package:graduation_project_app/util/transaction_list.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Column(
            children: [
              const Row(
                children: [
                  Balancetile(),
                ],
              ),
              const Row(
                children: [
                  IncomeTile(),
                  SizedBox(
                    width: 16,
                  ),
                  ExpenseTile(),
                ],
              ),
              Expanded(
                child: SizedBox.expand(
                  child: const TransactionList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
