import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mo_marketplace/core/common_widgets/app_drawer.dart';
import 'package:mo_marketplace/core/common_widgets/loading_placeholder_widgets/mo_item_placeholder.dart';
import 'package:mo_marketplace/core/common_widgets/mo_item_tile.dart';
import 'package:mo_marketplace/core/common_widgets/common_searchbar.dart';
import 'package:mo_marketplace/core/common_widgets/main_layout.dart';
import 'package:mo_marketplace/core/config/app_routes.dart';
import 'package:mo_marketplace/core/utils/navigation_util.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';
import 'package:mo_marketplace/data/models/main_category.dart';
import 'package:mo_marketplace/data/models/product_item.dart';
import 'package:mo_marketplace/feature/product/view_model/product_viewmodel.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({
    super.key,
    required this.productType,
    this.categoryId,
  });
  final String productType;
  final int? categoryId;

  @override
  ConsumerState<ProductListScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<ProductListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.categoryId != null) {
        ref
            .read(productViewModelProvider.notifier)
            .getProducts(categoryId: widget.categoryId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isScrollingEnabled: true,
      appBarTitle: "Products",
      marginValue: getDeviceWidth(context) * 0.04,
      appBarCenterTitle: true,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonSearchbar(searchController: _searchController),
          defaultSpace(context),
          Text(
            widget.productType,
            style: TextStyle(
              fontSize: AppDimensions.largeFontSize(context) * 0.9,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
          ),
          defaultSpace(context),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getDeviceWidth(context) * 0.04,
            ),
            child: productList(),
          ),
          defaultSpace(context),
        ],
      ),
    );
  }

  Widget productList() {
    final productState = ref.watch(productViewModelProvider).getProducts;
    return widget.categoryId != null
        ? productState!.when(
            data: (data) {
              return data.isEmpty
                  ? SizedBox(
                      height: getDeviceHeight(context) * 0.4,
                      child: Center(
                        child: Text(
                          'No products found!',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize:
                                AppDimensions.smallFontSize(context) * 0.9,
                          ),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: getDeviceWidth(context) * 0.05,
                        crossAxisSpacing: getDeviceWidth(context) * 0.03,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            pushScreen(
                              context,
                              AppRoutes.toProductDetailsScreen,
                              arguments: {'product': data[index]},
                            );
                          },
                          child: MOCommonItemTile(
                            itemName: (data[index].name ?? '').toUpperCase(),
                            itemImage: data[index].image ?? '',
                            price: data[index].price.toString(),
                          ),
                        );
                      },
                    );
            },
            error: (error, stackTrace) {
              return SizedBox(
                height: getDeviceHeight(context) * 0.4,
                child: Center(
                  child: Text(
                    'No products found!',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: AppDimensions.smallFontSize(context) * 0.9,
                    ),
                  ),
                ),
              );
            },
            loading: () {
              return GridView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: getDeviceWidth(context) * 0.05,
                  crossAxisSpacing: getDeviceWidth(context) * 0.03,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (_, __) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: const MOCommonItemTileLoading(),
                  );
                },
              );
            },
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: topProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: getDeviceWidth(context) * 0.05,
              crossAxisSpacing: getDeviceWidth(context) * 0.03,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  pushScreen(
                    context,
                    AppRoutes.toProductDetailsScreen,
                    arguments: {'product': topProducts[index]},
                  );
                },
                child: MOCommonItemTile(
                  itemName: (topProducts[index].name ?? '').toUpperCase(),
                  itemImage: topProducts[index].image ?? '',
                  price: topProducts[index].price.toString(),
                ),
              );
            },
          );
  }
}
