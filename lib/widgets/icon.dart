import 'package:flutter/material.dart';
import 'package:motorcycle_repair/constants/font_size.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const IconWidget({
    super.key,
    required this.icon,
    this.size = FontSize.iconLarge,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
