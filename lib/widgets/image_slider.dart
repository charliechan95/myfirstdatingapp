import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;
  final double height;

  const ImageSlider({
    super.key,
    required this.imageUrls,
    this.height = 350,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return Container(
        height: height,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageUrls[index].startsWith('assets')
                    ? AssetImage(imageUrls[index])
                    : NetworkImage(imageUrls[index]) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
