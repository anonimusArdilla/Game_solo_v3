import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:game_solo_v3/core/audio/audio_manager.dart';
import 'package:game_solo_v3/core/di/di.dart';
import 'package:game_solo_v3/game/game_solo_game.dart';
import 'package:game_solo_v3/l10n/app_localizations.dart';
import 'package:game_solo_v3/ui/screens/settings_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameSoloGame _game;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    _game = GameSoloGame(
      onPauseChanged: (value) {
        setState(() => _paused = value);
      },
    );
    _initAudio();
  }

  Future<void> _initAudio() async {
    final audio = di<AudioManager>();
    await audio.preload();
    await audio.playBgm();
  }

  @override
  void dispose() {
    unawaited(di<AudioManager>().stopBgm());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<GameSoloGame>(
        game: _game,
        overlayBuilderMap: {
          'hud': (context, game) => _HudOverlay(
                paused: _paused,
                onPauseToggle: () {
                  if (_paused) {
                    game.resumeGame();
                    game.overlays.remove('pause_menu');
                  } else {
                    game.pauseGame();
                    game.overlays.add('pause_menu');
                  }
                },
              ),
          'pause_menu': (context, game) => _PauseMenuOverlay(
                onResume: () {
                  game.resumeGame();
                  game.overlays.remove('pause_menu');
                },
                onSettings: () {
                  unawaited(
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const SettingsScreen(),
                      ),
                    ),
                  );
                },
              ),
        },
        initialActiveOverlays: const ['hud'],
      ),
    );
  }
}

class _HudOverlay extends StatelessWidget {
  const _HudOverlay({
    required this.paused,
    required this.onPauseToggle,
  });

  final bool paused;
  final VoidCallback onPauseToggle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: IconButton.filled(
            onPressed: onPauseToggle,
            icon: Icon(paused ? Icons.play_arrow : Icons.pause),
          ),
        ),
      ),
    );
  }
}

class _PauseMenuOverlay extends StatelessWidget {
  const _PauseMenuOverlay({
    required this.onResume,
    required this.onSettings,
  });

  final VoidCallback onResume;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Container(
      color: Colors.black.withValues(alpha: 0.65),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  onPressed: onResume,
                  child: Text(strings.resume),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: onSettings,
                  child: Text(strings.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

