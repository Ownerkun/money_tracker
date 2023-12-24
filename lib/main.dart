import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/data/category_data.dart';
import 'package:graduation_project_app/data/transaction_data.dart';
import 'package:graduation_project_app/helper/navigator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionData()),
        ChangeNotifierProvider(create: (context) => CategoryData())
        // ChangeNotifierProvider(create: (context) => CategoryData()), // Add CategoryData provider
        // Add more providers if needed
      ],
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (
            ColorScheme? light,
            ColorScheme? dark,
          ) {
            return MaterialApp(
              theme: ThemeData(
                fontFamily: 'Prompt',
                colorScheme: light,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                fontFamily: 'Prompt',
                colorScheme: dark,
                useMaterial3: true,
                brightness: Brightness.dark,
              ),
              home: const AppNavigator(),
            );
          },
        );
      },
    );
  }
}
