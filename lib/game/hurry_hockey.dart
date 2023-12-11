import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:hurry_hockey/config/config.dart';
import 'package:hurry_hockey/game/components/audio_player_component.dart';
import 'package:hurry_hockey/game/components/timer_bar.dart';
import 'package:hurry_hockey/widgets/overlays/game_over_menu.dart';

class HurryHockey extends FlameGame {
  late TimerBar timerBar;
  late Timer timer;

  late AudioPlayerComponent _audioPlayerComponent;

  @override
  bool debugMode = false;

  @override
  Future<void> onLoad() async {
    _audioPlayerComponent = AudioPlayerComponent();
    timerBar = TimerBar(
      position: Vector2(size.x / 2 - 150, 10),
      anchor: Anchor.center,
    );
    final clockIcon = await Sprite.load(PngAssets.clockIcon);
    SpriteComponent clock = SpriteComponent(
        sprite: clockIcon, position: Vector2(timerBar.position.x - 50, 10));

    addAll([
      _audioPlayerComponent,
      clock,
      timerBar,
    ]);
    return super.onLoad();
  }

  @override
  void onAttach() {
    _audioPlayerComponent.playBgm(AudioAssets.bgAudio);
    super.onAttach();
  }

  @override
  void update(double dt) {
    gameOver();
    super.update(dt);
  }

  nextTurn() async {
    timerBar.resetTimer();
  }

  gameOver() {
    pauseEngine();
    overlays.add(GameOverMenu.id);
  }

  void reset() {
    timerBar.reset();
  }

  @override
  void onDetach() {
    _audioPlayerComponent.stopBgm();
    super.onDetach();
  }
}
