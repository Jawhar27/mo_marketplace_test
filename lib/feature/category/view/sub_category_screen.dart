import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/common_widgets/common_searchbar.dart';
import 'package:mo_marketplace/core/common_widgets/main_layout.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';
import 'package:mo_marketplace/data/models/product_item.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, required this.mainCategory});
  final String mainCategory;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarCenterTitle: true,
      appBarTitle: 'Sub Category',
      marginValue: getDeviceWidth(context) * 0.04,
      child: Column(
        children: [
          CommonSearchbar(searchController: searchController),
          defaultSpace(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.mainCategory.toUpperCase(),
                style: TextStyle(
                  fontSize: AppDimensions.largeFontSize(context),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "View all",
                style: TextStyle(
                  fontSize: AppDimensions.mediumFontSize(context),
                ),
              ),
            ],
          ),
          defaultSpace(context),
          Expanded(
            child: ListView.builder(
              itemCount: topProducts.length,
              itemBuilder: (context, index) {
                ProductItem productItem = topProducts[index];
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: getDeviceWidth(context) * 0.02,
                            bottom: getDeviceWidth(context) * 0.03,
                          ),
                          width: getDeviceWidth(context) * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getDeviceWidth(context) * 0.03,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl: productItem.image!,
                            fit: BoxFit.cover,
                            width: getDeviceWidth(context),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(width: getDeviceWidth(context) * 0.03),
                        Text(
                          productItem.name!.toUpperCase(),
                          style: TextStyle(
                            fontSize:
                                AppDimensions.largeFontSize(context) * 0.9,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
