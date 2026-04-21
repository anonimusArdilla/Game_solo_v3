import 'package:flutter/material.dart';

import 'package:game_solo_v3/core/audio/audio_manager.dart';
import 'package:game_solo_v3/core/di/di.dart';
import 'package:game_solo_v3/l10n/app_localizations.dart';
import 'package:game_solo_v3/ui/screens/game_screen.dart';
import 'package:game_solo_v3/ui/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final audio = di<AudioManager>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    strings.appTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () async {
                      audio.playTap();
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const GameScreen(),
                        ),
                      );
                    },
                    child: Text(strings.play),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () async {
                      audio.playTap();
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                    child: Text(strings.settings),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

