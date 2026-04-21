import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:game_solo_v3/core/persistence/key_value_store.dart';

class LocaleController extends ChangeNotifier {
  LocaleController(this._store);

  static const _storageKey = 'selected_locale_code';

  final KeyValueStore _store;

  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> loadInitial(Locale deviceLocale) async {
    final stored = await _store.getString(_storageKey);
    if (stored != null && stored.isNotEmpty) {
      _locale = Locale(stored);
    } else {
      _locale = _supportedOrDefault(deviceLocale);
    }
    notifyListeners();
  }

  Future<void> updateLocale(Locale locale) async {
    _locale = locale;
    await _store.setString(_storageKey, locale.languageCode);
    notifyListeners();
  }

  Locale _supportedOrDefault(Locale deviceLocale) {
    const supportedCodes = ['en', 'zh', 'ja', 'ko', 'th', 'id'];
    final languageCode = deviceLocale.languageCode.toLowerCase();
    if (supportedCodes.contains(languageCode)) {
      return Locale(languageCode);
    }
    return const Locale('en');
  }
}

