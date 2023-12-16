import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hurry_hockey/config/config.dart';
import 'package:hurry_hockey/core/constants/app_colors.dart';
import 'package:hurry_hockey/game/components/audio_player_component.dart';
import 'package:hurry_hockey/game/components/enemy.dart';
import 'package:hurry_hockey/game/components/player.dart';
import 'package:hurry_hockey/game/components/target.dart';
import 'package:hurry_hockey/widgets/overlays/game_over_menu.dart';

class HurryHockey extends FlameGame with TapDetector, HasCollisionDetection {
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
  late Player _player;
  late Enemy _enemyA, _enemyB, _enemyC, _enemyD;
  late Target _target;
  int count = 0;
  bool isWin = false;
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {
    _enemyA = Enemy(spritePath: PngAssets.enemyA, position: size / 2);
    _enemyB = Enemy(
        spritePath: PngAssets.enemyB,
        position: Vector2(size.x / 5, size.y - 75));
    _enemyC = Enemy(
      spritePath: PngAssets.enemyC,
      position: Vector2(size.x / 2 + 100, size.y / 2 + 100),
    );
    _enemyD = Enemy(
      spritePath: PngAssets.enemyD,
      position: Vector2(size.x * 2 / 3 - 50, size.y / 2 + 50),
    );

    _target = Target(
      spritePath: PngAssets.target,
      position: Vector2(size.x - 150, size.y / 2 + 50),
    );
    _audioPlayerComponent = AudioPlayerComponent();
    final clockIcon = await Sprite.load(PngAssets.clockIcon);
    SpriteComponent clock = SpriteComponent(
        sprite: clockIcon,
        position: Vector2(size.x / 2, 30),
        anchor: Anchor.center);
    _player = Player(position: Vector2(0, size.y - 50));
    camera.follow(_player);
    addAll([_audioPlayerComponent, clock, _player, _enemyA]);
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
  void onTapDown(TapDownInfo info) {
    _player.jump();
    super.onTapDown(info);
  }

  @override
  void update(double dt) {
    interval.update(dt);
    if (countdown <= 0) {
      gameOver();
    }
    if (_player.position.x > size.x) {
      _player.position.x = 0;
      count += 1;
      if (count == 1) {
        children.whereType<Enemy>().forEach((enemy) {
          enemy.removeFromParent();
        });
        add(_enemyB);
        add(_enemyC);
      } else if (count == 2) {
        children.whereType<Enemy>().forEach((enemy) {
          enemy.removeFromParent();
        });
        add(_enemyD);
      } else if (count == 3) {
        children.whereType<Enemy>().forEach((enemy) {
          enemy.removeFromParent();
        });
        add(_target);
      }
    }
    super.update(dt);
  }

  gameOver() {
    pauseEngine();
    overlays.add(GameOverMenu.id);
  }

  void reset() {
    countdown = 60;
    _player.position = Vector2(0, size.y - 50);
    _player.reset();
    count = 0;
    children.whereType<Enemy>().forEach((enemy) {
      enemy.removeFromParent();
    });
    children.whereType<Target>().forEach((cheese) {
      cheese.removeFromParent();
    });
    add(_enemyA);
  }

  @override
  void onDetach() {
    _audioPlayerComponent.stopBgm();
    super.onDetach();
  }
}
