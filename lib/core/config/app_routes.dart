import 'package:flutter/material.dart';
import 'package:mo_marketplace/data/models/product_item.dart';
import 'package:mo_marketplace/feature/category/view/sub_category_screen.dart';
import 'package:mo_marketplace/feature/home/view/home_screen.dart';
import 'package:mo_marketplace/feature/product/view/product_details_screen.dart';
import 'package:mo_marketplace/feature/product/view/product_list_screen.dart';
import 'package:mo_marketplace/main_screen.dart';
import 'package:mo_marketplace/splash_screen.dart';

class AppRoutes {
  static const String toSplashScreen = 'toSplashScreen';
  static const String toHomeScreen = 'toHomeScreen';
  static const String toMainScreen = 'toMainScreen';
  static const String toSubCategoryScreen = 'toSubCategoryScreen';
  static const String toProductDetailsScreen = "toProductDetailsScreen";
  static const String toProductListScreen = "toProductListScreen";
}

class OnRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.toHomeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.toMainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case AppRoutes.toSubCategoryScreen:
        final args = (settings.arguments is Map<String, dynamic>)
            ? settings.arguments as Map<String, dynamic>
            : <String, dynamic>{};
        String category = args['mainCategory'];
        return MaterialPageRoute(
          builder: (_) => SubCategoryScreen(mainCategory: category),
        );
      case AppRoutes.toProductListScreen:
        final args = (settings.arguments is Map<String, dynamic>)
            ? settings.arguments as Map<String, dynamic>
            : <String, dynamic>{};
        String productType = args['productType'];
        int? categoryId = args['categoryId'];
        return MaterialPageRoute(
          builder: (_) => ProductListScreen(
            productType: productType,
            categoryId: categoryId,
          ),
        );

      case AppRoutes.toProductDetailsScreen:
        final args = (settings.arguments is Map<String, dynamic>)
            ? settings.arguments as Map<String, dynamic>
            : <String, dynamic>{};
        ProductItem product = args['product'] as ProductItem;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );

      case AppRoutes.toSplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
