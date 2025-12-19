import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;

  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -1),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        iconSize: getDeviceWidth(context) * 0.12,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppDimensions.mediumFontSize(context) * 0.85,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: AppDimensions.mediumFontSize(context) * 0.75,
        ),
        items: [
          _buildStyledItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Home',
            isSelected: currentIndex == 0,
            context: context,
          ),
          _buildStyledItem(
            icon: Icons.category_outlined,
            selectedIcon: Icons.category,
            label: 'Category',
            isSelected: currentIndex == 1,
            context: context,
          ),
          _buildStyledItem(
            icon: Icons.add_circle_outline,
            selectedIcon: Icons.add_circle,
            label: 'Add',
            isSelected: currentIndex == 2,
            context: context,
          ),
          _buildStyledItem(
            icon: Icons.chat_bubble_outline,
            selectedIcon: Icons.chat_bubble,
            label: 'Chat',
            isSelected: currentIndex == 3,
            context: context,
          ),
          _buildStyledItem(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: 'Login',
            isSelected: currentIndex == 4,
            context: context,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildStyledItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.all(getDeviceWidth(context) * 0.01),
        padding: EdgeInsets.symmetric(
          vertical: getDeviceWidth(context) * 0.01,
          horizontal: getDeviceWidth(context) * 0.02,
        ),

        child: label == "Home"
            ? Image.asset('assets/images/app_icon.png')
            : Icon(
                isSelected ? selectedIcon : icon,
                size: isSelected
                    ? getDeviceWidth(context) * 0.07
                    : getDeviceWidth(context) * 0.05,
              ),
      ),
      label: label,
    );
  }
}
