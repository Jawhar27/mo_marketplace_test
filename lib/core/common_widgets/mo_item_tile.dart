import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class MOCommonItemTile extends StatelessWidget {
  const MOCommonItemTile({
    super.key,
    required this.itemName,
    required this.itemImage,
    this.price,
  });
  final String itemName;
  final String itemImage;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getDeviceWidth(context) * 0.04),
          ),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            imageUrl: itemImage,
            fit: BoxFit.cover,
            placeholder: (context, url) => SizedBox(
              height: getDeviceWidth(context) * 0.1,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error, color: Colors.red)),
          ),
        ),
        Text(
          itemName,
          style: TextStyle(
            color: Colors.grey,
            fontSize: AppDimensions.smallFontSize(context) * 0.85,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        if (price != null)
          Text(
            price!,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppDimensions.mediumFontSize(context) * 0.9,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
    ;
  }
}
