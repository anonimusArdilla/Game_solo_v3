import 'package:flutter/services.dart';

class FontManager {
  final Set<String> _loadedFamilies = <String>{};

  Future<void> preloadForLanguageCode(String languageCode) async {
    await _loadFamilyIfNeeded(
      family: 'NotoSans',
      assetPath: 'assets/fonts/NotoSans-Regular.ttf',
    );

    if (languageCode == 'th') {
      await _loadFamilyIfNeeded(
        family: 'NotoSansThai',
        assetPath: 'assets/fonts/NotoSansThai-Regular.ttf',
      );
    }

    if (languageCode == 'zh') {
      await _loadFamilyIfNeeded(
        family: 'NotoSansCJKsc',
        assetPath: 'assets/fonts/NotoSansCJKsc-Regular.otf',
      );
    }

    if (languageCode == 'ja') {
      await _loadFamilyIfNeeded(
        family: 'NotoSansCJKjp',
        assetPath: 'assets/fonts/NotoSansCJKjp-Regular.otf',
      );
    }

    if (languageCode == 'ko') {
      await _loadFamilyIfNeeded(
        family: 'NotoSansCJKkr',
        assetPath: 'assets/fonts/NotoSansCJKkr-Regular.otf',
      );
    }
  }

  Future<void> _loadFamilyIfNeeded({
    required String family,
    required String assetPath,
  }) async {
    if (_loadedFamilies.contains(family)) {
      return;
    }
    final loader = FontLoader(family);
    final data = await rootBundle.load(assetPath);
    loader.addFont(Future<ByteData>.value(data));
    await loader.load();
    _loadedFamilies.add(family);
  }
}
