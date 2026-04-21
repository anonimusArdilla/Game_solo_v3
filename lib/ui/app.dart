import 'package:flutter/material.dart';

import 'package:game_solo_v3/core/di/di.dart';
import 'package:game_solo_v3/core/localization/locale_controller.dart';
import 'package:game_solo_v3/l10n/app_localizations.dart';
import 'package:game_solo_v3/ui/screens/home_screen.dart';

class GameSoloApp extends StatelessWidget {
  const GameSoloApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = di<LocaleController>();
    return AnimatedBuilder(
      animation: localeController,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          locale: localeController.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFEDC15E),
              brightness: Brightness.dark,
            ),
            fontFamily: 'NotoSans',
            textTheme: _withFallbackFonts(ThemeData.dark().textTheme),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }

  TextTheme _withFallbackFonts(TextTheme base) {
    const fallback = <String>[
      'NotoSansCJKsc',
      'NotoSansCJKjp',
      'NotoSansCJKkr',
      'NotoSansThai',
    ];

    TextStyle? patch(TextStyle? style) {
      if (style == null) {
        return null;
      }
      return style.copyWith(fontFamilyFallback: fallback);
    }

    return base.copyWith(
      displayLarge: patch(base.displayLarge),
      displayMedium: patch(base.displayMedium),
      displaySmall: patch(base.displaySmall),
      headlineLarge: patch(base.headlineLarge),
      headlineMedium: patch(base.headlineMedium),
      headlineSmall: patch(base.headlineSmall),
      titleLarge: patch(base.titleLarge),
      titleMedium: patch(base.titleMedium),
      titleSmall: patch(base.titleSmall),
      bodyLarge: patch(base.bodyLarge),
      bodyMedium: patch(base.bodyMedium),
      bodySmall: patch(base.bodySmall),
      labelLarge: patch(base.labelLarge),
      labelMedium: patch(base.labelMedium),
      labelSmall: patch(base.labelSmall),
    );
  }
}

