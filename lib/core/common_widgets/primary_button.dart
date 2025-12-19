import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/config/app_colors.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? getDeviceWidth(context) * 0.12,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          color: backgroundColor ?? AppColors.primary,
        ),

        child: Center(
          child: Text(
            title,
            style:
                textStyle ??
                TextStyle(
                  color: Colors.white,
                  fontSize: AppDimensions.mediumFontSize(context),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
