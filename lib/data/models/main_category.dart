import 'package:flutter/material.dart';

class MainCategory {
  final int? id;
  final String? name;
  final String? image;
  final IconData? testIcon;

  const MainCategory({this.id, this.name, this.image, this.testIcon});

  factory MainCategory.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const MainCategory();

    return MainCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }

  MainCategory copyWith({
    int? id,
    String? name,
    String? image,
    IconData? testIcon,
  }) {
    return MainCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      testIcon: testIcon ?? this.testIcon,
    );
  }
}

final List<MainCategory> sampleMainCategoryList = [
  MainCategory(
    id: 1,
    name: "Women's Fashion",
    image: "https://picsum.photos/200?grayscale&random=1",
    testIcon: Icons.woman_rounded,
  ),
  MainCategory(
    id: 2,
    name: "Men's Fashion",
    image: "https://picsum.photos/200?grayscale&random=2",
    testIcon: Icons.man_rounded,
  ),
  MainCategory(
    id: 3,
    name: "Babies & Kids",
    image: "https://picsum.photos/200?grayscale&random=3",
    testIcon: Icons.child_care_rounded,
  ),
  MainCategory(
    id: 4,
    name: "Furniture & Home Living",
    image: "https://picsum.photos/200?grayscale&random=4",
    testIcon: Icons.chair_rounded,
  ),
  MainCategory(
    id: 5,
    name: "Toys Games & Books",
    image: "https://picsum.photos/200?grayscale&random=5",
    testIcon: Icons.toys_rounded,
  ),
  MainCategory(
    id: 6,
    name: "Beauty & Personal Care",
    image: "https://picsum.photos/200?grayscale&random=6",
    testIcon: Icons.brush_rounded,
  ),
  MainCategory(
    id: 7,
    name: "TV & Home Appliances",
    image: "https://picsum.photos/200?grayscale&random=7",
    testIcon: Icons.tv_rounded,
  ),
  MainCategory(
    id: 8,
    name: "Sports Equipment",
    image: "https://picsum.photos/200?grayscale&random=8",
    testIcon: Icons.sports_soccer_rounded,
  ),
  MainCategory(
    id: 9,
    name: "Computers & Tech",
    image: "https://picsum.photos/200?grayscale&random=9",
    testIcon: Icons.computer_rounded,
  ),
  MainCategory(
    id: 10,
    name: "Mobiles & Gadgets",
    image: "https://picsum.photos/200?grayscale&random=10",
    testIcon: Icons.smartphone_rounded,
  ),
  MainCategory(
    id: 11,
    name: "Health & Nutrition",
    image: "https://picsum.photos/200?grayscale&random=11",
    testIcon: Icons.health_and_safety_rounded,
  ),
  MainCategory(
    id: 12,
    name: "Video Gaming",
    image: "https://picsum.photos/200?grayscale&random=12",
    testIcon: Icons.videogame_asset_rounded,
  ),
  MainCategory(
    id: 13,
    name: "Photography",
    image: "https://picsum.photos/200?grayscale&random=13",
    testIcon: Icons.camera_alt_rounded,
  ),
  MainCategory(
    id: 14,
    name: "Pet Supplies",
    image: "https://picsum.photos/200?grayscale&random=14",
    testIcon: Icons.pets_rounded,
  ),
  MainCategory(
    id: 15,
    name: "Vehicle",
    image: "https://picsum.photos/200?grayscale&random=15",
    testIcon: Icons.directions_car_rounded,
  ),
  MainCategory(
    id: 16,
    name: "Property",
    image: "https://picsum.photos/200?grayscale&random=16",
    testIcon: Icons.house_rounded,
  ),
];
