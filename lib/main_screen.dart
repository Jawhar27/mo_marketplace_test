import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/common_widgets/main_bottom_navbar.dart';
import 'package:mo_marketplace/core/common_widgets/main_layout.dart';
import 'package:mo_marketplace/feature/auth/view/auth_screen.dart';
import 'package:mo_marketplace/feature/auth/view/login_required_screen.dart';
import 'package:mo_marketplace/feature/category/view/categories_screen.dart';
import 'package:mo_marketplace/feature/home/view/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget?> _screens = [null, null, null, null, null];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _screens[index] ??= _buildScreen(index);
    });
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return CategoryScreen();
      case 2:
        return LoginRequiredScreen();
      case 3:
        return LoginRequiredScreen(
          errorMessage: 'Please login to chat on the marketplace.',
        );
      default:
        return AuthScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    _screens[0] = HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      backgroundColor: Colors.white,
      isSafeArea: true,
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      child: _screens[_selectedIndex] ?? const SizedBox(),
    );
  }
}
