import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class CircleBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CircleBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final double size = getDeviceWidth(context) * 0.12;
    final double borderWidth = getDeviceWidth(context) * 0.004;
    final double iconSize = getDeviceWidth(context) * 0.06;

    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: borderWidth),
          color: Colors.transparent,
        ),
        child: Center(
          child: Icon(Icons.arrow_back, color: Colors.white, size: iconSize),
        ),
      ),
    );
  }
}
