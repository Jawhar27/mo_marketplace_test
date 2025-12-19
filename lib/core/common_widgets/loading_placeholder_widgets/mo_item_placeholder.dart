import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class MOCommonItemTileLoading extends StatelessWidget {
  const MOCommonItemTileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = getDeviceWidth(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: width * 0.4,
          width: width * 0.4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(width * 0.04),
          ),
        ),

        SizedBox(height: width * 0.02),

        Container(
          height: width * 0.035,
          width: width * 0.35,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
