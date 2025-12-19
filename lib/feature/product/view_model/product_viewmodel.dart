import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mo_marketplace/core/utils/custom_exceptions/api_exception.dart';
import 'package:mo_marketplace/core/utils/print_logs.dart';
import 'package:mo_marketplace/data/models/product_item.dart';
import 'package:mo_marketplace/feature/product/repository/product_repository.dart';

class ProductState {
  final AsyncValue<List<ProductItem>>? getProducts;
  final AsyncValue<ProductItem>? getProduct;

  ProductState({this.getProducts, this.getProduct});

  ProductState copyWith({
    AsyncValue<List<ProductItem>>? getProducts,
    AsyncValue<ProductItem>? getProduct,
  }) {
    return ProductState(
      getProducts: getProducts ?? this.getProducts,
      getProduct: getProduct ?? this.getProduct,
    );
  }
}

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>((ref) {
      final repo = ref.read(productRepositoryProvider);
      return ProductViewModel(repo);
    });

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductRepository _productRepository;

  ProductViewModel(this._productRepository)
    : super(
        ProductState(
          getProduct: const AsyncValue.loading(),
          getProducts: AsyncValue.loading(),
        ),
      );

  // GET ALL PRODUCTS FOR SPECIFIC CATEGORY
  Future<void> getProducts({required int categoryId}) async {
    printLogs("******* GETTING MAIN CATEGORIES *******");
    state = state.copyWith(getProducts: const AsyncValue.loading());
    try {
      final productsResponse = await _productRepository.getProducts(
        categoryId: categoryId,
      );
      state = state.copyWith(getProducts: AsyncValue.data(productsResponse));
    } on ApiException catch (e) {
      state = state.copyWith(
        getProducts: AsyncValue.error(
          e.message ?? "Something went wrong, please try again!",
          StackTrace.current,
        ),
      );
    } catch (e, st) {
      state = state.copyWith(getProducts: AsyncValue.error(e, st));
    }
  }

  // GET SINGLE PRODUCT
  Future<void> getProduct({required int productId}) async {
    printLogs("******* GETTING MAIN CATEGORIES *******");
    state = state.copyWith(getProduct: const AsyncValue.loading());
    try {
      final productsResponse = await _productRepository.getProduct(
        productId: productId,
      );
      state = state.copyWith(getProduct: AsyncValue.data(productsResponse));
    } on ApiException catch (e) {
      state = state.copyWith(
        getProduct: AsyncValue.error(
          e.message ?? "Something went wrong, please try again!",
          StackTrace.current,
        ),
      );
    } catch (e, st) {
      state = state.copyWith(getProduct: AsyncValue.error(e, st));
    }
  }
}
