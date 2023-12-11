import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hurry_hockey/config/assets/png_assets.dart';
import 'package:hurry_hockey/game/hurry_hockey.dart';
import 'package:hurry_hockey/widgets/overlays/game_over_menu.dart';
import 'package:hurry_hockey/widgets/overlays/pause_button.dart';
import 'package:hurry_hockey/widgets/overlays/pause_menu.dart';

HurryHockey _hurryHockey = HurryHockey();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        // GameWidget is useful to inject the underlying
        // widget of any class extending from Flame's Game class.
        child: GameWidget(
          backgroundBuilder: (context) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    PngAssets.backgroundGameplay,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Center(
              //   child: Text(
              //     context.l10n!.appName.toUpperCase(),
              //     style: const TextStyle(
              //         color: Color(
              //           0xFFFFA91F,
              //         ),
              //         fontSize: 50),
              //   ),
              // ),
            );
          },
          game: _hurryHockey,
          // Initially only pause button overlay will be visible.
          initialActiveOverlays: const [PauseButton.id],
          overlayBuilderMap: {
            PauseButton.id: (BuildContext context, HurryHockey game) =>
                PauseButton(
                  game: game,
                ),
            PauseMenu.id: (BuildContext context, HurryHockey game) => PauseMenu(
                  game: game,
                ),
            GameOverMenu.id: (BuildContext context, HurryHockey game) =>
                GameOverMenu(
                  game: game,
                ),
          },
        ),
      ),
    );
  }
}
