import 'package:flutter/material.dart';
import 'package:motorcycle_repair/constants/font_size.dart';

class TextWidget extends StatelessWidget {
  final String message;
  final Color color;
  final double size;
  final FontWeight weight;

  const TextWidget({
    super.key,
    required this.message,
    this.color = Colors.black,
    this.size = FontSize.fontSmall,
    this.weight = FontWeight.normal,
  });

  const TextWidget.title({
    super.key,
    this.message = "Not text",
  })  : color = Colors.black,
        size = FontSize.fontRegular,
        weight = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
