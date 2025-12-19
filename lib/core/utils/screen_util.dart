import 'package:flutter/material.dart';

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Widget defaultSpace(BuildContext context) {
  return SizedBox(height: getDeviceWidth(context) * 0.05);
}

class AppDimensions {
  static double smallFontSize(BuildContext context) {
    return getDeviceWidth(context) * 0.035;
  }

  static double mediumFontSize(BuildContext context) {
    return getDeviceWidth(context) * 0.04;
  }

  static double largeFontSize(BuildContext context) {
    return getDeviceWidth(context) * 0.045;
  }

  static double fontSizeXLarge(BuildContext context) {
    return getDeviceWidth(context) * 0.055;
  }

  static double fontSizeHuge(BuildContext context) {
    return getDeviceWidth(context) * 0.065;
  }

  static double hintFontSize(BuildContext context) {
    return getDeviceWidth(context) * 0.03;
  }

  static double formInputFontSize(BuildContext context) {
    return getDeviceWidth(context) * 0.036;
  }
}
