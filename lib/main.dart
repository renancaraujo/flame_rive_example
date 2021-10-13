import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
    final archerArtBoard = await loadArtboard(RiveFile.asset('assets/her.riv'));

    add(
      SpriteComponent(
          sprite: backgroundSprite, position: Vector2.all(0), size: size),
    );

    add(
      ArcherComponent(
        artboard: archerArtBoard,
        position: Vector2(608, 686),
        size: Vector2(841, 1342),
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

class ArcherComponent extends RiveComponent {
  ArcherComponent({
    required Artboard artboard,
    required Vector2 position,
    required Vector2 size,
  }) : super(
          artboard: artboard,
          position: position,
          size: size,
        );

  SMIInput<double>? _pullFactorInput;

  @override
  Future<void>? onLoad() {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "Pull",
    );
    if (controller != null) {
      artboard.addController(controller);
      _pullFactorInput = controller.findInput<double>('factor');
      _pullFactorInput?.value = 0;
    }
    return super.onLoad();
  }
}
