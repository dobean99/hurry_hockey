import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hurry_hockey/config/assets/png_assets.dart';
import 'package:hurry_hockey/game/components/enemy.dart';
import 'package:hurry_hockey/game/components/target.dart';
import 'package:hurry_hockey/game/hurry_hockey.dart';

// This component class represents the player character in game.
class Player extends SpriteComponent
    with CollisionCallbacks, HasGameReference<HurryHockey>, KeyboardHandler {
  Player({
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);
  @override
  void onLoad() async {
    sprite = await Sprite.load(PngAssets.player);
    return super.onLoad();
  }

  double yMax = 250;
  double speedY = 0.0;
  double speedX = 90.0;
  static const double gravity = 300;

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox.relative(
      0.5,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  jump() {
    speedX = 100;
    if (isOnGround) {
      speedY = -300;
    }
  }

  bool get isOnGround => (y >= yMax);
  @override
  void update(double dt) {
    speedY += gravity * dt;
    y += speedY * dt;
    x += speedX * dt;
    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      speedX = 90;
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy || other is Target) {
      game.gameOver();
    }
  }

  reset() {
    speedY = 0.0;
    speedX = 90;
  }
}
