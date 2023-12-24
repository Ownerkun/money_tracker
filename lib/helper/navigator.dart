import 'package:flutter/material.dart';
import 'package:graduation_project_app/page/category_page.dart';
import 'package:graduation_project_app/page/graph_page.dart';
import 'package:graduation_project_app/page/home_page.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const CategoryPage(),
    const GraphPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (newIndex) => setState(() => _selectedIndex = newIndex),
      ),
    );
  }
}
