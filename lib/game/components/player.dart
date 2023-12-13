import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hurry_hockey/config/assets/png_assets.dart';
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

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // if (other is Enemy) {
    //   game.gameOver();
    // }
    // if (other is Cheese) {
    //   if (game.buildContext != null) {
    //     if (Provider.of<Settings>(game.buildContext!, listen: false).bgm) {
    //       audioplayer.playBgm();
    //     }
    //   }
  }

  // This method is called by game class for every frame.
  @override
  void update(double dt) {
    super.update(dt);

    // Adds thruster particles.
  }
}
