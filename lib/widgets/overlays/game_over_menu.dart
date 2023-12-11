import 'package:flutter/material.dart';
import 'package:hurry_hockey/config/assets/png_assets.dart';
import 'package:hurry_hockey/config/l10n/l10n.dart';
import 'package:hurry_hockey/core/constants/app_colors.dart';
import 'package:hurry_hockey/game/hurry_hockey.dart';
import 'package:hurry_hockey/screens/main_menu.dart';
import 'package:hurry_hockey/widgets/commons/base_layout.dart';
import 'package:hurry_hockey/widgets/commons/circle_stroke_button.dart';
import 'package:hurry_hockey/widgets/commons/stroke_text.dart';

class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final HurryHockey game;
  const GameOverMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
          ),
          constraints: BoxConstraints(
              minWidth: 0,
              minHeight: 0,
              maxWidth: MediaQuery.sizeOf(context).width - 200,
              maxHeight: MediaQuery.sizeOf(context).height - 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StrokeText(
                text: context.l10n!.youWin,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(PngAssets.cupIcon),
                  Text(
                    context.l10n!.congrats,
                    style: const TextStyle(
                      color: AppColors.textTitleColor,
                      fontSize: 29,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleStrokeButton(
                      iconPath: PngAssets.playAgainIcon,
                      onPressed: () {
                        game.overlays.remove(GameOverMenu.id);
                        game.resumeEngine();
                        game.reset();
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  CircleStrokeButton(
                    iconPath: PngAssets.homeIcon,
                    onPressed: () {
                      game.overlays.remove(GameOverMenu.id);
                      game.resumeEngine();
                      game.reset();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
