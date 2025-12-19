import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class MainLayout extends StatelessWidget {
  final bool useScaffold;
  final bool isLoading;
  final bool isSafeArea;
  final bool isScrollingEnabled;
  final String? appBarTitle;
  final List<Widget>? appBarActions;
  final Widget child;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final double marginValue;
  final EdgeInsets? customMargin;
  final Widget? appBarLeading;
  final bool appBarCenterTitle;
  final Widget? drawer;
  final Widget? bottomNavigationBar;

  const MainLayout({
    super.key,
    required this.child,
    this.useScaffold = true,
    this.isLoading = false,
    this.isSafeArea = true,
    this.isScrollingEnabled = false,
    this.appBarTitle,
    this.appBarActions,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = false,
    this.customMargin,
    this.marginValue = 0,
    this.appBarLeading,
    this.appBarCenterTitle = false,
    this.drawer,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = isScrollingEnabled
        ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: child,
          )
        : child;

    if (isSafeArea) {
      content = SafeArea(child: content);
    }

    Widget body = Stack(
      children: [
        Container(
          margin: customMargin ?? EdgeInsets.all(marginValue),
          child: content,
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
    if (!useScaffold) {
      return body;
    }
    return Scaffold(
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: appBarTitle != null
          ? AppBar(
              centerTitle: appBarCenterTitle,
              backgroundColor: Colors.white,
              title: Text(
                appBarTitle!,
                style: TextStyle(
                  fontSize: AppDimensions.largeFontSize(context),
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: appBarLeading,
              actions: appBarActions,
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
