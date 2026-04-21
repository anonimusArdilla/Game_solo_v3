import 'package:game_solo_v3/core/audio/audio_manager.dart';
import 'package:game_solo_v3/core/fonts/font_manager.dart';
import 'package:game_solo_v3/core/localization/locale_controller.dart';
import 'package:game_solo_v3/core/persistence/key_value_store.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt di = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(prefs);
  di.registerSingleton<KeyValueStore>(SharedPreferencesKeyValueStore(prefs));
  di.registerSingleton<LocaleController>(LocaleController(di<KeyValueStore>()));
  di.registerSingleton<AudioManager>(AudioManager());
  di.registerSingleton<FontManager>(FontManager());
}

