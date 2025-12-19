import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool obscureText;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final double? borderRadius;
  final bool isEnabled;
  final bool isSearchBar;
  final int? maxLines;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final int? errorMaxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.label, // Added label to constructor
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.borderRadius,
    this.isEnabled = true,
    this.isSearchBar = false,
    this.maxLines = 1,
    this.keyboardType,
    this.focusNode,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.errorText,
    this.contentPadding,
    this.prefix,
    this.errorMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? getDeviceWidth(context) * 0.05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(bottom: getDeviceWidth(context) * 0.02),
            child: Text(
              label!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppDimensions.smallFontSize(context),
                color: Colors.black87,
              ),
            ),
          ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          enabled: isEnabled,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: TextStyle(fontSize: AppDimensions.formInputFontSize(context)),
          decoration: InputDecoration(
            contentPadding: contentPadding,
            prefixIcon: prefix,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
            errorStyle: TextStyle(
              fontSize: AppDimensions.smallFontSize(context),
            ),
            fillColor: Colors.grey[200],
            filled: true,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: AppDimensions.smallFontSize(context),
              fontWeight: FontWeight.w600,
            ),
            suffixIcon: isSearchBar ? const Icon(Icons.search) : suffixIcon,
          ),
        ),
      ],
    );
  }
}
