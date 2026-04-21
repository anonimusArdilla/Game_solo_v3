import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvValidator {
  EnvValidator._();

  static void validate() {
    _requireNonEmpty('FLAVOR');

    final firebaseEnabled = _readBool('FEATURE_FIREBASE');
    if (firebaseEnabled) {
      _requireNonEmpty('FIREBASE_PROJECT_ID');
      _requireNonEmpty('FIREBASE_APP_ID_ANDROID');
      _requireNonEmpty('FIREBASE_APP_ID_IOS');
      _requireNonEmpty('FIREBASE_API_KEY');
    }

    final adsEnabled = _readBool('FEATURE_ADS');
    if (adsEnabled) {
      _requireNonEmpty('ADMOB_APP_ID_ANDROID');
      _requireNonEmpty('ADMOB_APP_ID_IOS');
      _requireNonEmpty('ADMOB_REWARDED_AD_UNIT_ID');
      _requireNonEmpty('ADMOB_INTERSTITIAL_AD_UNIT_ID');
    }

    final minFetchInterval =
        _requireParseInt('REMOTE_CONFIG_MIN_FETCH_INTERVAL_SECONDS');
    if (minFetchInterval < 60) {
      throw StateError(
        'REMOTE_CONFIG_MIN_FETCH_INTERVAL_SECONDS must be at least 60 seconds',
      );
    }
  }

  static String _requireNonEmpty(String key) {
    final value = dotenv.env[key];
    if (value == null || value.trim().isEmpty) {
      throw StateError('Missing required environment variable: $key');
    }
    return value;
  }

  static int _requireParseInt(String key) {
    final raw = _requireNonEmpty(key);
    final value = int.tryParse(raw);
    if (value == null) {
      throw StateError('Environment variable $key must be an integer');
    }
    return value;
  }

  static bool _readBool(String key) {
    final raw = _requireNonEmpty(key).toLowerCase().trim();
    return switch (raw) {
      'true' || '1' || 'yes' => true,
      'false' || '0' || 'no' => false,
      _ => throw StateError('Environment variable $key must be a boolean'),
    };
  }
}

