import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mo_marketplace/core/utils/screen_util.dart';

class BannerCarousel extends StatelessWidget {
  final List<String> bannerImages;

  const BannerCarousel({super.key, required this.bannerImages});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = getDeviceWidth(context);

    return CarouselSlider(
      options: CarouselOptions(
        height: getDeviceHeight(context) * 0.25,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: false,
      ),
      items: bannerImages.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: deviceWidth,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: deviceWidth,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error, color: Colors.red)),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
