import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hurry_hockey/config/config.dart';
import 'package:hurry_hockey/core/constants/app_colors.dart';
import 'package:hurry_hockey/game/components/audio_player_component.dart';
import 'package:hurry_hockey/game/components/player.dart';
import 'package:hurry_hockey/widgets/overlays/game_over_menu.dart';

class HurryHockey extends FlameGame {
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
        color: AppColors.whiteColor,
        fontSize: 29,
        fontFamily: "CeraPro",
        fontWeight: FontWeight.w900),
  );
  late AudioPlayerComponent _audioPlayerComponent;
  late Timer interval;
  int countdown = 60;
  late Player player;

  @override
  bool debugMode = false;

  @override
  Future<void> onLoad() async {
    _audioPlayerComponent = AudioPlayerComponent();
    final clockIcon = await Sprite.load(PngAssets.clockIcon);
    SpriteComponent clock = SpriteComponent(
        sprite: clockIcon,
        position: Vector2(size.x / 2, 30),
        anchor: Anchor.center);
    player = Player(
      position: size / 2,
    );
    addAll([
      _audioPlayerComponent,
      clock,
      player,
    ]);
    return super.onLoad();
  }

  @override
  void onMount() {
    super.onMount();
    interval = Timer(
      1,
      onTick: () => countdown -= 1,
      repeat: true,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textPaint.render(
      canvas,
      countdown.toString(),
      Vector2(size.x / 2, 10),
    );
  }

  @override
  void onAttach() {
    _audioPlayerComponent.playBgm(AudioAssets.bgAudio);
    super.onAttach();
  }

  @override
  void update(double dt) {
    interval.update(dt);
    if (countdown <= 0) {
      gameOver();
    }
    super.update(dt);
  }

  gameOver() {
    pauseEngine();
    overlays.add(GameOverMenu.id);
  }

  void reset() {
    countdown = 60;
  }

  @override
  void onDetach() {
    _audioPlayerComponent.stopBgm();
    super.onDetach();
  }
}
