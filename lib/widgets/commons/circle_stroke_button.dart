import 'package:flutter/material.dart';

class CircleStrokeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String iconPath;
  final double? width;
  final bool isEnable;
  final double? scale;

  const CircleStrokeButton({
    super.key,
    this.onPressed,
    this.width,
    this.isEnable = true,
    required this.iconPath,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: InkWell(
          onTap: onPressed, child: Image.asset(iconPath, scale: scale ?? 1)),
    );
  }
}
