import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mo_marketplace/core/utils/custom_exceptions/api_exception.dart';
import 'package:mo_marketplace/core/utils/print_logs.dart';
import 'package:mo_marketplace/data/models/main_category.dart';
import 'package:mo_marketplace/feature/category/repository/category_repository.dart';

class CategoryState {
  final AsyncValue<List<MainCategory>>? getMainCategories;

  CategoryState({this.getMainCategories});

  CategoryState copyWith({AsyncValue<List<MainCategory>>? getMainCategories}) {
    return CategoryState(
      getMainCategories: getMainCategories ?? this.getMainCategories,
    );
  }
}

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, CategoryState>((ref) {
      final repo = ref.read(categoryRepositoryProvider);
      return CategoryViewModel(repo);
    });

class CategoryViewModel extends StateNotifier<CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryViewModel(this._categoryRepository)
    : super(CategoryState(getMainCategories: const AsyncValue.loading()));

  Future<void> getMainCategories() async {
    printLogs("******* GETTING MAIN CATEGORIES *******");
    state = state.copyWith(getMainCategories: const AsyncValue.loading());
    try {
      final categoryResponse = await _categoryRepository.getMainCategories();
      state = state.copyWith(
        getMainCategories: AsyncValue.data(categoryResponse),
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        getMainCategories: AsyncValue.error(
          e.message ?? "Something went wrong, please try again!",
          StackTrace.current,
        ),
      );
    } catch (e, st) {
      state = state.copyWith(getMainCategories: AsyncValue.error(e, st));
    }
  }
}
