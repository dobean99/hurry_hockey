import 'package:flutter/material.dart';
import 'package:hurry_hockey/config/assets/png_assets.dart';
import 'package:hurry_hockey/game/hurry_hockey.dart';
import 'package:hurry_hockey/widgets/commons/circle_stroke_button.dart';
import 'package:hurry_hockey/widgets/overlays/pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String id = 'PauseButton';
  final HurryHockey game;

  const PauseButton({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 20.0),
        child: CircleStrokeButton(
          width: 50,
          child: Image.asset(PngAssets.pauseIcon),
          onPressed: () {
            game.pauseEngine();
            game.overlays.add(PauseMenu.id);
          },
        ),
      ),
    );
  }
}
