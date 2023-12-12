import 'package:flutter/material.dart';
import 'package:hurry_hockey/config/assets/png_assets.dart';
import 'package:hurry_hockey/core/constants/app_colors.dart';
import 'package:hurry_hockey/game/hurry_hockey.dart';
import 'package:hurry_hockey/screens/main_menu.dart';
import 'package:hurry_hockey/widgets/commons/circle_stroke_button.dart';

class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';
  final HurryHockey game;
  const PauseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor.withAlpha(100),
      body: Center(
        child: Container(
          height: 200,
          width: 360,
          decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleStrokeButton(
                    iconPath: PngAssets.homeIcon,
                    onPressed: () {
                      game.overlays.remove(PauseMenu.id);
                      game.reset();
                      game.resumeEngine();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MainMenu(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  CircleStrokeButton(
                    iconPath: PngAssets.arrowBackIcon,
                    onPressed: () {
                      game.resumeEngine();
                      game.overlays.remove(PauseMenu.id);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
