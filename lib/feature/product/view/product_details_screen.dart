import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/common_widgets/back_button.dart';
import 'package:mo_marketplace/core/common_widgets/main_layout.dart';
import 'package:mo_marketplace/core/common_widgets/primary_button.dart';
import 'package:mo_marketplace/core/config/assets.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';
import 'package:mo_marketplace/data/models/product_item.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductItem product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedRadioBTNValue;
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isSafeArea: false,
      isScrollingEnabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _productImage(),
          defaultSpace(context),
          Text(
            widget.product.name ?? '',
            style: TextStyle(
              fontSize: AppDimensions.largeFontSize(context),
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: getDeviceWidth(context) * 0.01),
          RichText(
            text: TextSpan(
              text: 'by',
              style: TextStyle(
                color: Colors.black,
                fontSize: AppDimensions.largeFontSize(context),
              ),
              children: [
                TextSpan(
                  text: widget.product.manufacturer ?? ' Shiro',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: AppDimensions.largeFontSize(context),
                  ),
                ),
              ],
            ),
          ),
          defaultSpace(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RS. ${widget.product.price ?? 100}',
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeHuge(context),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: getDeviceWidth(context) * 0.02),
              Container(
                height: getDeviceWidth(context) * 0.08,
                width: getDeviceWidth(context) * 0.3,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Fixed Price',
                    style: TextStyle(
                      fontSize: AppDimensions.mediumFontSize(context),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          defaultSpace(context),
          PrimaryButton(
            borderRadius: BorderRadius.circular(getDeviceWidth(context) * 0.06),
            width: getDeviceWidth(context) * 0.45,
            title: 'ADD TO CART',
            textStyle: TextStyle(
              fontSize: AppDimensions.largeFontSize(context),
              color: Colors.white,
            ),
            backgroundColor: const Color.fromARGB(255, 1, 47, 84),
          ),
          defaultSpace(context),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getDeviceWidth(context) * 0.04,
            ),
            height: getDeviceHeight(context) * 0.08,
            width: double.infinity,
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                productSizeInfo(
                  title: 'Dimensions',
                  value: '9cm x 12cm x 14cm',
                ),
                SizedBox(height: getDeviceWidth(context) * 0.005),
                productSizeInfo(title: 'Weight', value: '1.0 kg'),
              ],
            ),
          ),
          defaultSpace(context),
          _addressInfo(),
          defaultSpace(context),
          Container(height: 1, width: double.infinity, color: Colors.grey[300]),
          defaultSpace(context),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getDeviceWidth(context) * 0.04,
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share this on',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimensions.largeFontSize(context),
                  ),
                ),
                SizedBox(height: getDeviceWidth(context) * 0.03),
                Padding(
                  padding: EdgeInsets.only(
                    left: getDeviceWidth(context) * 0.04,
                  ),
                  child: Row(
                    children: [
                      shareOptionButton(img: whatsapp),
                      SizedBox(width: getDeviceWidth(context) * 0.04),
                      shareOptionButton(img: facebook),
                      SizedBox(width: getDeviceWidth(context) * 0.04),
                      shareOptionButton(img: instagram),
                    ],
                  ),
                ),
              ],
            ),
          ),
          defaultSpace(context),
          Container(height: 1, width: double.infinity, color: Colors.grey[300]),
          defaultSpace(context),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getDeviceWidth(context) * 0.04,
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report this Product',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimensions.largeFontSize(context),
                  ),
                ),
                SizedBox(height: getDeviceWidth(context) * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getDeviceWidth(context) * 0.03,
                  ),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      final List<String> options = [
                        'False information',
                        'Damaged Item',
                        'Not baby safe',
                        'Other',
                      ];

                      List<Widget> rows = [];
                      for (int i = 0; i < options.length; i += 2) {
                        rows.add(
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  value: options[i],
                                  groupValue: selectedRadioBTNValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioBTNValue = value;
                                    });
                                  },
                                  title: Text(options[i]),
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                              if (i + 1 < options.length)
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: options[i + 1],
                                    groupValue: selectedRadioBTNValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRadioBTNValue = value;
                                      });
                                    },
                                    title: Text(options[i + 1]),
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }
                      return Column(children: rows);
                    },
                  ),
                ),
                defaultSpace(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                      height: getDeviceHeight(context) * 0.04,
                      width: getDeviceWidth(context) * 0.25,
                      backgroundColor: Colors.grey[500],
                      title: 'Cancel',
                    ),
                    SizedBox(width: getDeviceWidth(context) * 0.03),
                    PrimaryButton(
                      height: getDeviceHeight(context) * 0.04,
                      width: getDeviceWidth(context) * 0.35,
                      backgroundColor: Colors.redAccent,
                      title: 'Send Report',
                    ),
                  ],
                ),
                defaultSpace(context),
                defaultSpace(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget shareOptionButton({required String img, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: getDeviceWidth(context) * 0.04,
        backgroundImage: AssetImage(img),
      ),
    );
  }

  Widget _addressInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        commonTextTile(info: 'SY Fashion'),
        SizedBox(height: getDeviceWidth(context) * 0.005),
        commonTextTile(info: 'Size 28'),
        SizedBox(height: getDeviceWidth(context) * 0.005),
        commonTextTile(info: 'High west'),
        SizedBox(height: getDeviceWidth(context) * 0.005),
        commonTextTile(info: 'Whatsapp 0777860230'),
        SizedBox(height: getDeviceWidth(context) * 0.02),
        Container(
          height: getDeviceWidth(context) * 0.1,
          width: getDeviceWidth(context) * 0.15,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[600]!, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "#",
              style: TextStyle(fontSize: AppDimensions.largeFontSize(context)),
            ),
          ),
        ),
      ],
    );
  }

  Widget commonTextTile({required String info}) {
    return Text(
      info,
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: AppDimensions.mediumFontSize(context),
      ),
    );
  }

  Widget productSizeInfo({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: AppDimensions.mediumFontSize(context)),
        ),
        Text(
          value,
          style: TextStyle(fontSize: AppDimensions.mediumFontSize(context)),
        ),
      ],
    );
  }

  Widget _productImage() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: getDeviceHeight(context) * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 10),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),

          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            imageUrl:
                widget.product.image ??
                "https://picsum.photos/200?grayscale&random=1",
            fit: BoxFit.cover,
            width: getDeviceWidth(context),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error, color: Colors.red)),
          ),
        ),
        Positioned(
          top: getDeviceHeight(context) * 0.08,
          left: getDeviceWidth(context) * 0.05,
          child: CircleBackButton(),
        ),
        Positioned(
          bottom: getDeviceHeight(context) * 0.03,
          left: getDeviceWidth(context) * 0.05,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getDeviceWidth(context) * 0.02,
                vertical: getDeviceWidth(context) * 0.01,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: getDeviceWidth(context) * 0.05,
                    color: Colors.white,
                  ),
                  SizedBox(width: getDeviceWidth(context) * 0.005),
                  Text(
                    "13 Views",
                    style: TextStyle(
                      fontSize: AppDimensions.smallFontSize(context),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
