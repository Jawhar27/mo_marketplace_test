import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class CategoryPlaceholder extends StatelessWidget {
  const CategoryPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: getDeviceWidth(context) * 0.01),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: getDeviceWidth(context) * 0.12,
            width: getDeviceWidth(context) * 0.12,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: getDeviceWidth(context) * 0.03),

          Container(
            height: getDeviceHeight(context) * 0.02,
            width: getDeviceWidth(context) * 0.15,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
