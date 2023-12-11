import 'package:hurry_hockey/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CircleStrokeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String iconPath;
  final double? width;
  final bool isEnable;

  const CircleStrokeButton({
    super.key,
    this.onPressed,
    this.width,
    this.isEnable = true,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: InkWell(onTap: onPressed, child: Image.asset(iconPath)),
    );
  }
}
