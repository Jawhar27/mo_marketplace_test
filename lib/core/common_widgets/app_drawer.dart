import 'package:flutter/material.dart';

Drawer appDrawer({required BuildContext context}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.red),
          child: Text(
            'MO Marketplace',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            // close drawer
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Cart'),
          onTap: () {
            // Navigate to Cart screen
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          onTap: () {
            // Navigate to Profile screen
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            // Navigate to Settings
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            Navigator.pop(context);
            // Handle logout
          },
        ),
      ],
    ),
  );
}
