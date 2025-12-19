import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/common_widgets/main_layout.dart';
import 'package:mo_marketplace/core/common_widgets/primary_button.dart';
import 'package:mo_marketplace/core/config/app_colors.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class LoginRequiredScreen extends StatelessWidget {
  final VoidCallback? onLogin;
  final String? errorMessage;

  const LoginRequiredScreen({super.key, this.onLogin, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      useScaffold: true,
      isSafeArea: true,
      backgroundColor: Colors.black.withOpacity(0.6),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getDeviceWidth(context) * 0.06,
          ),
          child: Container(
            padding: EdgeInsets.all(getDeviceWidth(context) * 0.06),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/app_icon.png',
                  height: getDeviceWidth(context) * 0.4,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: getDeviceWidth(context) * 0.05),

                Text(
                  'Login Required',
                  style: TextStyle(
                    fontSize: AppDimensions.largeFontSize(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: getDeviceWidth(context) * 0.03),

                Text(
                  errorMessage != null
                      ? errorMessage!
                      : 'Please login to add items to the marketplace.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppDimensions.mediumFontSize(context),
                    color: Colors.grey[700],
                  ),
                ),

                SizedBox(height: getDeviceWidth(context) * 0.07),

                PrimaryButton(title: 'Login'),

                SizedBox(height: getDeviceWidth(context) * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
