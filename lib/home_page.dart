import 'package:flutter/material.dart';
import 'package:graduation_project_app/util/balance_tile.dart';
import 'package:graduation_project_app/util/expense_tile.dart';
import 'package:graduation_project_app/util/income_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: const Column(
          children: [
            Row(
              children: [
                Balancetile(),
              ],
            ),
            Row(
              children: [
                IncomeTile(),
                SizedBox(
                  width: 16,
                ),
                ExpenseTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
