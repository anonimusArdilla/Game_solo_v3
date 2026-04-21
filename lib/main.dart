import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:game_solo_v3/core/bootstrap.dart';
import 'package:game_solo_v3/core/di/di.dart';
import 'package:game_solo_v3/core/fonts/font_manager.dart';
import 'package:game_solo_v3/core/localization/locale_controller.dart';
import 'package:game_solo_v3/ui/app.dart';

Future<void> main() async {
  await bootstrap();

  final localeController = di<LocaleController>();
  await localeController.loadInitial(PlatformDispatcher.instance.locale);
  await di<FontManager>().preloadForLanguageCode(
    (localeController.locale ?? const Locale('en')).languageCode,
  );

  runApp(const ProviderScope(child: GameSoloApp()));
}
