import 'package:flutter/material.dart';

class Balancetile extends StatelessWidget {
  const Balancetile({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 150,
        child: Card(
          shadowColor: Colors.grey,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('500,000.00'),
              Text('Balance'),
            ],
          ),
        ),
      ),
    );
  }
}
