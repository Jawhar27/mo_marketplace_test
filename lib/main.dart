import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mo_marketplace/core/config/app_routes.dart';
import 'package:mo_marketplace/core/config/app_theme.dart';
import 'package:mo_marketplace/core/providers/theme_provider.dart';
import 'package:mo_marketplace/feature/home/view/home_screen.dart';
import 'package:mo_marketplace/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'MO MarketPlace',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: SplashScreen(),
      onGenerateRoute: OnRouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
