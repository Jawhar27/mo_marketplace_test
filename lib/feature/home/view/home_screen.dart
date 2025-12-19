import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mo_marketplace/core/common_widgets/app_drawer.dart';
import 'package:mo_marketplace/core/common_widgets/banner_carousel.dart';
import 'package:mo_marketplace/core/common_widgets/common_searchbar.dart';
import 'package:mo_marketplace/core/common_widgets/custom_text_field.dart';
import 'package:mo_marketplace/core/common_widgets/loading_placeholder_widgets/category_placeholder.dart';
import 'package:mo_marketplace/core/common_widgets/main_layout.dart';
import 'package:mo_marketplace/core/config/app_routes.dart';
import 'package:mo_marketplace/core/utils/navigation_util.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';
import 'package:mo_marketplace/data/models/main_category.dart';
import 'package:mo_marketplace/data/models/product_item.dart';
import 'package:mo_marketplace/feature/category/view_model/category_viewmodel.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
      appBarTitle: "Welcome",
      drawer: appDrawer(context: context),
      appBarLeading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getDeviceWidth(context) * 0.04,
            ),
            child: CommonSearchbar(searchController: _searchController),
          ),
          defaultSpace(context),
          _mainCategoryList(),
          defaultSpace(context),
          _banners(),
          defaultSpace(context),
          _topProducts(),
          defaultSpace(context),
          _moDesigner(),
          defaultSpace(context),
          _recentlyAddedProducts(),
          defaultSpace(context),
          Container(
            width: double.infinity,
            color: Colors.blueGrey[50],
            height: getDeviceHeight(context) * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MO",
                  style: TextStyle(
                    fontSize: AppDimensions.fontSizeHuge(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "That's more like it",
                  style: TextStyle(
                    fontSize: AppDimensions.mediumFontSize(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          defaultSpace(context),
          productsList(),
          defaultSpace(context),
        ],
      ),
    );
  }

  Widget productsList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: topProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: getDeviceWidth(context) * 0.05,
        childAspectRatio: 0.9,
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
          child: _productItem(product: topProducts[index], isExpanded: false),
        );
      },
    );
  }

  Widget _recentlyAddedProducts() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getDeviceWidth(context) * 0.01),
      height: getDeviceHeight(context) * 0.6,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _titleWithClick(
                prefixIcon: Icons.alarm,
                title: 'Recently Added',
                prefixIconColor: Colors.red,
              ),
              _circleButton(),
            ],
          ),
          defaultSpace(context),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (topProducts.length / 2).ceil(),
              itemBuilder: (context, index) {
                final firstItem = topProducts[index * 2];
                final secondItemIndex = index * 2 + 1;
                final secondItem = secondItemIndex < topProducts.length
                    ? topProducts[secondItemIndex]
                    : null;

                return Padding(
                  padding: EdgeInsets.only(
                    right: getDeviceWidth(context) * 0.02,
                  ),
                  child: Column(
                    children: [
                      Expanded(child: _productItem(product: firstItem)),
                      defaultSpace(context),

                      Expanded(
                        child: (secondItem != null)
                            ? _productItem(product: secondItem)
                            : SizedBox(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _moDesigner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getDeviceWidth(context) * 0.01),
      height: getDeviceHeight(context) * 0.25,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _titleWithClick(
                prefixText: Text(
                  "MO",
                  style: TextStyle(
                    fontSize: AppDimensions.fontSizeHuge(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                title: 'Designer',
              ),
              _circleButton(),
            ],
          ),
          defaultSpace(context),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: designerProducts.length,
              separatorBuilder: (_, __) =>
                  SizedBox(width: getDeviceWidth(context) * 0.02),
              itemBuilder: (context, index) {
                ProductItem designerProduct = designerProducts[index];
                return SizedBox(
                  width: getDeviceWidth(context) * 0.3,
                  child: _productItem(product: designerProduct),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleWithClick({
    IconData? prefixIcon,
    required String title,
    Text? prefixText,
    IconData? postIcon,
    Color? postIconColor,
    Color? prefixIconColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getDeviceWidth(context) * 0.03),
          child: Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(
                  prefixIcon,
                  color: prefixIconColor,
                  size: getDeviceWidth(context) * 0.07,
                ),
                SizedBox(width: getDeviceWidth(context) * 0.01),
              ],
              if (prefixText != null) ...[
                prefixText,
                SizedBox(width: getDeviceWidth(context) * 0.01),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXLarge(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (postIcon != null) ...[
                SizedBox(width: getDeviceWidth(context) * 0.01),
                Icon(
                  postIcon,
                  color: postIconColor,
                  size: getDeviceWidth(context) * 0.07,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _topProducts() {
    final deviceWidth = getDeviceWidth(context);
    final deviceHeight = getDeviceHeight(context);

    return Container(
      // color: Colors.amber,
      height: deviceHeight * 0.4,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _titleWithClick(
                title: 'Top Products',
                postIcon: Icons.star,
                postIconColor: Colors.orangeAccent,
              ),
              _circleButton(
                onTap: () {
                  pushScreen(
                    context,
                    AppRoutes.toProductListScreen,
                    arguments: {'productType': 'Top Products'},
                  );
                },
              ),
            ],
          ),
          defaultSpace(context),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getDeviceWidth(context) * 0.01,
            ),
            height: getDeviceHeight(context) * 0.13,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: deviceWidth * 0.24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: deviceWidth * 0.18,
                        height: deviceWidth * 0.18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: deviceWidth * 0.08,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(height: deviceWidth * 0.01),
                      Text(
                        "Boost Your Product",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                          fontSize: AppDimensions.smallFontSize(context) * 0.7,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                Flexible(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        topProducts.length, // replace with your product count
                    separatorBuilder: (_, __) =>
                        SizedBox(width: deviceWidth * 0.02),
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: deviceWidth * 0.18,
                          height: deviceWidth * 0.18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 2),
                          ),

                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: topProducts[index].image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.error, color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          defaultSpace(context),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: topProducts.length,
              separatorBuilder: (_, __) => SizedBox(width: deviceWidth * 0.02),
              itemBuilder: (context, index) {
                ProductItem topProduct = topProducts[index];
                return SizedBox(
                  width: getDeviceWidth(context) * 0.3,
                  child: _productItem(product: topProduct),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _productItem({required ProductItem product, bool isExpanded = true}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isExpanded
            ? Expanded(
                child: Container(
                  width: getDeviceWidth(context) * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getDeviceWidth(context) * 0.04,
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: product.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error, color: Colors.red)),
                  ),
                ),
              )
            : Container(
                width: getDeviceWidth(context) * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getDeviceWidth(context) * 0.04,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error, color: Colors.red)),
                ),
              ),

        SizedBox(height: getDeviceWidth(context) * 0.01),
        Text(
          product.name ?? '',
          style: TextStyle(
            color: Colors.grey,
            fontSize: AppDimensions.smallFontSize(context),
            fontWeight: FontWeight.w800,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: getDeviceWidth(context) * 0.01),
        Text(
          'RS: ${product.price}',
          style: TextStyle(
            fontSize: AppDimensions.mediumFontSize(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _circleButton({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.grey[200],
        radius: getDeviceWidth(context) * 0.05,
        child: Icon(Icons.arrow_forward, size: getDeviceWidth(context) * 0.06),
      ),
    );
  }

  Widget _banners() {
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: getDeviceHeight(context) * 0.25,
      child: BannerCarousel(
        bannerImages: [
          "https://picsum.photos/1080/400?random=1",
          "https://picsum.photos/1080/400?random=2",
          "https://picsum.photos/1080/400?random=3",
        ],
      ),
    );
  }

  Widget _mainCategoryList() {
    final categoryState = ref
        .watch(categoryViewModelProvider)
        .getMainCategories;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getDeviceWidth(context) * 0.03),
      height: getDeviceHeight(context) * 0.1,
      child: categoryState!.when(
        data: (data) {
          return data.isEmpty
              ? Center(
                  child: Text(
                    'No main categories found!',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: AppDimensions.smallFontSize(context) * 0.9,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sampleMainCategoryList.length,
                  itemBuilder: (context, index) {
                    MainCategory mainCategory = sampleMainCategoryList[index];
                    return GestureDetector(
                      onTap: () {
                        pushScreen(
                          context,
                          AppRoutes.toSubCategoryScreen,
                          arguments: {'mainCategory': mainCategory.name},
                        );
                      },
                      child: Container(
                        width: getDeviceWidth(context) * 0.2,
                        margin: EdgeInsets.only(
                          right: getDeviceWidth(context) * 0.01,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Icon(
                                mainCategory.testIcon,
                                size: getDeviceWidth(context) * 0.1,
                              ),
                            ),
                            Text(
                              mainCategory.name ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize:
                                    AppDimensions.smallFontSize(context) * 0.9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
        error: (error, stackTrace) {
          return SizedBox.shrink();
        },
        loading: () {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (context, index) {
              return SizedBox(width: getDeviceWidth(context) * 0.02);
            },
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: const CategoryPlaceholder(),
              );
            },
          );
        },
      ),
    );
  }
}
