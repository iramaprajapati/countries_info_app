import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double? imgWidth;
  final double? imgHeight;
  final double? imgPlaceholderWidth;
  final double? imgPlaceholderHeight;
  final BoxFit? imgFit;

  const CustomImage({
    super.key,
    required this.imageUrl,
    this.imgWidth = 80.0,
    this.imgHeight = 100.0,
    this.imgFit = BoxFit.fill,
    this.imgPlaceholderWidth = 80.0,
    this.imgPlaceholderHeight = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: const AssetImage(
          'assets/placeholderImage.jpg'), // Placeholder image while loading
      image: NetworkImage(imageUrl ?? ''), // The actual network image
      fadeInDuration:
          const Duration(milliseconds: 400), // Duration for the fade-in
      width: imgWidth,
      height: imgHeight,
      fit: imgFit,
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        // Return the placeholder if the network image fails to load
        return Image.asset(
          'assets/placeholderImage.jpg',
          width: imgPlaceholderWidth,
          height: imgPlaceholderHeight,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
