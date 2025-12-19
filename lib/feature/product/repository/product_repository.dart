import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mo_marketplace/core/network/api_service.dart';
import 'package:mo_marketplace/data/models/main_category.dart';
import 'package:mo_marketplace/data/models/product_item.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ProductRepository(apiService);
});

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<ProductItem>> getProducts({required int categoryId}) async {
    await Future.delayed(Duration(seconds: 3));

    return allProducts
        .where((product) => product.categoryId == categoryId)
        .toList();
  }

  Future<ProductItem> getProduct({required int productId}) async {
    await Future.delayed(const Duration(seconds: 3));
    return topProducts.firstWhere((product) => product.id == productId);
  }
}
