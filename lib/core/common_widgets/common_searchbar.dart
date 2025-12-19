import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/common_widgets/custom_text_field.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class CommonSearchbar extends StatelessWidget {
  const CommonSearchbar({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: searchController,
      prefix: Icon(Icons.search),
      hintText: "Search MO Marketplace",
    );
  }
}
