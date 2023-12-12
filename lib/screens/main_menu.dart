import 'package:flutter/material.dart';
import 'package:hurry_hockey/config/assets/png_assets.dart';
import 'package:hurry_hockey/config/l10n/l10n.dart';
import 'package:hurry_hockey/core/constants/app_colors.dart';
import 'package:hurry_hockey/screens/game_play.dart';
import 'package:hurry_hockey/screens/settings_screen.dart';
import 'package:hurry_hockey/widgets/commons/base_layout.dart';
import 'package:hurry_hockey/widgets/commons/circle_stroke_button.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(PngAssets.logo),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleStrokeButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.whiteColor,
                            content: Text(
                              context.l10n!.gameInstructions,
                              style: const TextStyle(
                                color: AppColors.textTitleColor,
                                fontSize: 29,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              CircleStrokeButton(
                                iconPath: PngAssets.arrowRightIcon,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                            actionsAlignment: MainAxisAlignment.center,
                          );
                        },
                      );
                    },
                    iconPath: PngAssets.infoIcon,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  CircleStrokeButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GamePlay(),
                        ),
                      );
                    },
                    iconPath: PngAssets.playIcon,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 30),
                child: CircleStrokeButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  iconPath: PngAssets.settingsIcon,
                ),
              ))
        ],
      ),
    );
  }
}
