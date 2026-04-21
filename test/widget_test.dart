import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_solo_v3/core/di/di.dart';
import 'package:game_solo_v3/core/localization/locale_controller.dart';
import 'package:game_solo_v3/ui/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App boots', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await di.reset();
    await configureDependencies();
    await di<LocaleController>().loadInitial(const Locale('en'));

    await tester.pumpWidget(const ProviderScope(child: GameSoloApp()));
    await tester.pump();
    expect(find.byType(GameSoloApp), findsOneWidget);
  });
}
