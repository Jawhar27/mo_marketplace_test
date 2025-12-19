import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/common_widgets/custom_text_field.dart';
import 'package:mo_marketplace/core/common_widgets/main_layout.dart';
import 'package:mo_marketplace/core/common_widgets/primary_button.dart';
import 'package:mo_marketplace/core/config/app_colors.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';
import 'package:mo_marketplace/core/utils/validators_util.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  final TextEditingController loginMobileController = TextEditingController();

  final TextEditingController registerFullNameController =
      TextEditingController();
  final TextEditingController registerDisplayNameController =
      TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerMobileController =
      TextEditingController();
  final TextEditingController registerReferralCodeController =
      TextEditingController();

  // FocusNodes
  final FocusNode loginMobileFocus = FocusNode();

  final FocusNode registerFullNameFocus = FocusNode();
  final FocusNode registerDisplayNameFocus = FocusNode();
  final FocusNode registerEmailFocus = FocusNode();
  final FocusNode registerMobileFocus = FocusNode();
  final FocusNode registerReferralFocus = FocusNode();

  @override
  void dispose() {
    loginMobileController.dispose();

    registerFullNameController.dispose();
    registerDisplayNameController.dispose();
    registerEmailController.dispose();
    registerMobileController.dispose();
    registerReferralCodeController.dispose();

    loginMobileFocus.dispose();

    registerFullNameFocus.dispose();
    registerDisplayNameFocus.dispose();
    registerEmailFocus.dispose();
    registerMobileFocus.dispose();
    registerReferralFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      useScaffold: true,
      isSafeArea: true,
      isScrollingEnabled: false,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: getDeviceHeight(context) * 0.15,
              child: Image.asset('assets/images/app_icon.png'),
            ),
            defaultSpace(context),
            TabBar(
              labelColor: Colors.black,
              indicatorColor: AppColors.primary,
              unselectedLabelColor: Colors.grey[400]!,
              labelStyle: TextStyle(
                fontSize: AppDimensions.mediumFontSize(context),
              ),
              tabs: const [
                Tab(text: 'LOGIN'),
                Tab(text: 'REGISTER'),
              ],
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(getDeviceWidth(context) * 0.04),
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            defaultSpace(context),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize:
                                    AppDimensions.fontSizeHuge(context) * 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.01),
                            Text(
                              "Please login to continue",
                              style: TextStyle(
                                fontSize: AppDimensions.largeFontSize(context),
                                color: Colors.grey[400],
                              ),
                            ),
                            defaultSpace(context),
                            CustomTextField(
                              controller: loginMobileController,
                              focusNode: loginMobileFocus,
                              keyboardType: TextInputType.phone,
                              hintText: 'Enter mobile number',
                              validator: validateMobileNo,
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.06),
                            PrimaryButton(
                              title: 'Login',
                              onPressed: () {
                                if (_loginFormKey.currentState!.validate()) {}
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),

                      child: Form(
                        key: _registerFormKey,
                        child: Column(
                          children: [
                            defaultSpace(context),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize:
                                    AppDimensions.fontSizeHuge(context) * 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.01),
                            Text(
                              "Create an account",
                              style: TextStyle(
                                fontSize: AppDimensions.largeFontSize(context),
                                color: Colors.grey[400],
                              ),
                            ),
                            defaultSpace(context),
                            CustomTextField(
                              controller: registerFullNameController,
                              focusNode: registerFullNameFocus,
                              hintText: 'Full Name',
                              validator: (val) =>
                                  validateNotEmpty(val, 'full name'),
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.04),
                            CustomTextField(
                              controller: registerDisplayNameController,
                              focusNode: registerDisplayNameFocus,
                              hintText: 'Display Name',
                              validator: (val) =>
                                  validateNotEmpty(val, 'display name'),
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.04),
                            CustomTextField(
                              controller: registerEmailController,
                              focusNode: registerEmailFocus,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Email',
                              validator: validateEmail,
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.04),
                            CustomTextField(
                              controller: registerMobileController,
                              focusNode: registerMobileFocus,
                              keyboardType: TextInputType.phone,
                              hintText: 'Mobile Number',
                              validator: validateMobileNo,
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.04),
                            CustomTextField(
                              controller: registerReferralCodeController,
                              focusNode: registerReferralFocus,
                              hintText: 'Referral Code (optional)',
                            ),
                            SizedBox(height: getDeviceWidth(context) * 0.06),
                            PrimaryButton(
                              title: 'Register',
                              onPressed: () {
                                if (_registerFormKey.currentState!
                                    .validate()) {}
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
