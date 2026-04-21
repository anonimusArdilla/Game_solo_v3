import 'dart:async';

import 'package:flutter/material.dart';

import 'package:game_solo_v3/core/audio/audio_manager.dart';
import 'package:game_solo_v3/core/di/di.dart';
import 'package:game_solo_v3/core/fonts/font_manager.dart';
import 'package:game_solo_v3/core/localization/locale_controller.dart';
import 'package:game_solo_v3/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final localeController = di<LocaleController>();
    final audio = di<AudioManager>();
    final fonts = di<FontManager>();

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              strings.language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: localeController,
              builder: (context, _) {
                return DropdownButtonFormField<Locale>(
                  initialValue: localeController.locale ?? const Locale('en'),
                  items: _localeItems(strings),
                  onChanged: (value) async {
                    if (value == null) {
                      return;
                    }
                    audio.playTap();
                    await fonts.preloadForLanguageCode(value.languageCode);
                    await localeController.updateLocale(value);
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            Text(strings.audio, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SwitchListTile.adaptive(
              value: audio.muted,
              onChanged: (value) {
                audio.playTap();
                unawaited(audio.setMuted(muted: value));
              },
              title: Text(strings.mute),
            ),
            ListTile(
              title: Text(strings.music),
              subtitle: Slider(
                value: audio.musicVolume,
                onChanged: (value) => unawaited(audio.setMusicVolume(value)),
              ),
            ),
            ListTile(
              title: Text(strings.sfx),
              subtitle: Slider(
                value: audio.sfxVolume,
                onChanged: audio.setSfxVolume,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<Locale>> _localeItems(AppLocalizations strings) {
    return const [
      Locale('en'),
      Locale('zh'),
      Locale('ja'),
      Locale('ko'),
      Locale('th'),
      Locale('id'),
    ].map((locale) {
      return DropdownMenuItem<Locale>(
        value: locale,
        child: Text(_localeLabel(strings, locale.languageCode)),
      );
    }).toList();
  }

  String _localeLabel(AppLocalizations strings, String code) {
    return switch (code) {
      'en' => strings.lang_en,
      'zh' => strings.lang_zh,
      'ja' => strings.lang_ja,
      'ko' => strings.lang_ko,
      'th' => strings.lang_th,
      'id' => strings.lang_id,
      _ => code,
    };
  }
}

