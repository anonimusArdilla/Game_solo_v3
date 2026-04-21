import 'package:shared_preferences/shared_preferences.dart';

abstract class KeyValueStore {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
}

class SharedPreferencesKeyValueStore implements KeyValueStore {
  SharedPreferencesKeyValueStore(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }
}

