import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final game = RiveExampleGame();

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
    );
  }
}

class RiveExampleGame extends FlameGame {
  @override
  Future<void>? onLoad() async {
    camera.viewport = FixedResolutionViewport(Vector2(3185, 2758));
    await super.onLoad();

    // load stuff
    final backgroundSprite = await loadSprite('ambient_background.jpg');
    final foregroundSprite = await loadSprite('ambient_foreground.png');

    add(
      SpriteComponent(
          sprite: backgroundSprite, position: Vector2.all(0), size: size),
    );

    add(
      PlayerComponent(
        position: Vector2(608, 636),
        size: Vector2(841, 1342 ),
      ),
    );

    add(
      SpriteComponent(
        sprite: foregroundSprite,
        position: Vector2.all(0),
        size: size,
      ),
    );
  }
}

class PlayerComponent extends PositionComponent {
  final _paintGreen = BasicPalette.green.paint();

  @override
  Vector2 size;

  PlayerComponent({
    Vector2? position,
    required this.size,
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paintGreen);
  }
}
