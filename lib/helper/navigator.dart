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
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        children: const [
          HomePage(),
          CategoryPage(),
          GraphPage(),
        ],
      ),
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
            label: 'Graph',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (newIndex) => _pageController.animateToPage(newIndex,
            duration: const Duration(milliseconds: 500), curve: Curves.ease),
      ),
    );
  }
}
