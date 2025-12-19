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
import 'package:mo_marketplace/feature/category/view_model/category_viewmodel.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryViewModelProvider.notifier).getMainCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isScrollingEnabled: true,
      appBarTitle: "Categories",
      marginValue: getDeviceWidth(context) * 0.04,
      appBarCenterTitle: true,
      drawer: appDrawer(context: context),
      appBarLeading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonSearchbar(searchController: _searchController),
          defaultSpace(context),
          Text(
            'TOP CATEGORIES',
            style: TextStyle(
              fontSize: AppDimensions.largeFontSize(context) * 0.85,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
          ),
          defaultSpace(context),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getDeviceWidth(context) * 0.04,
            ),
            child: categorylist(),
          ),
          defaultSpace(context),
        ],
      ),
    );
  }

  Widget categorylist() {
    final categoryState = ref
        .watch(categoryViewModelProvider)
        .getMainCategories;
    return categoryState!.when(
      data: (data) {
        return data.isEmpty
            ? SizedBox(
                height: getDeviceHeight(context) * 0.4,
                child: Center(
                  child: Text(
                    'No categories found!',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: AppDimensions.smallFontSize(context) * 0.9,
                    ),
                  ),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sampleMainCategoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: getDeviceWidth(context) * 0.05,
                  crossAxisSpacing: getDeviceWidth(context) * 0.03,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      pushScreen(
                        context,
                        AppRoutes.toProductListScreen,
                        arguments: {
                          'productType': data[index].name,
                          'categoryId': data[index].id,
                        },
                      );
                    },
                    child: MOCommonItemTile(
                      itemName: (data[index].name ?? '').toUpperCase(),
                      itemImage: data[index].image ?? '',
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
              'No categories found!',
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
            childAspectRatio: 0.85,
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
    );
  }
}
