import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mo_marketplace/core/network/api_service.dart';
import 'package:mo_marketplace/data/models/main_category.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return CategoryRepository(apiService);
});

class CategoryRepository {
  final ApiService _apiService;

  CategoryRepository(this._apiService);

  Future<List<MainCategory>> getMainCategories() async {
    await Future.delayed(Duration(seconds: 3));
    return sampleMainCategoryList;
  }
}
