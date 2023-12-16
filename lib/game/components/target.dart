import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hurry_hockey/game/components/player.dart';
import 'package:hurry_hockey/game/hurry_hockey.dart';

class Target extends SpriteComponent
    with CollisionCallbacks, HasGameReference<HurryHockey> {
  final _random = Random();

  late String spritePath;
  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2.random(_random)) * 500;
  }

  Vector2 getRandomDirection() {
    return (Vector2.random(_random) - Vector2(0.5, -1)).normalized();
  }

  Target({
    required this.spritePath,
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(spritePath);
  }

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox.relative(
      2,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Player) {
      game.isWin = true;
    }
  }
}
