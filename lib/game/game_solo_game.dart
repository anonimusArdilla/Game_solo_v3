import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:game_solo_v3/core/audio/audio_manager.dart';
import 'package:game_solo_v3/core/di/di.dart';

class GameSoloGame extends FlameGame with TapCallbacks {
  GameSoloGame({required this.onPauseChanged});

  final ValueChanged<bool> onPauseChanged;

  late final _LanternPlayer _player;

  @override
  Color backgroundColor() => const Color(0xFF0B1020);

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(resolution: Vector2(360, 640));
    _player = _LanternPlayer()
      ..position = Vector2(180, 520)
      ..anchor = Anchor.center;
    add(_player);
  }

  @override
  void onTapDown(TapDownEvent event) {
    di<AudioManager>().playTap();
    _player.nudge(event.localPosition.x < size.x / 2 ? -1 : 1);
  }

  void pauseGame() {
    pauseEngine();
    onPauseChanged(true);
  }

  void resumeGame() {
    resumeEngine();
    onPauseChanged(false);
  }
}

class _LanternPlayer extends PositionComponent {
  _LanternPlayer() : super(size: Vector2.all(42));

  double _vx = 0;

  void nudge(int direction) {
    _vx += 180.0 * direction;
    _vx = _vx.clamp(-420.0, 420.0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += _vx * dt;
    _vx *= 0.86;
    position.x = position.x.clamp(size.x / 2, 360 - size.x / 2);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFF8D477);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
    final inner = Paint()..color = const Color(0xFFFFF1B3);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 3, inner);
  }
}

