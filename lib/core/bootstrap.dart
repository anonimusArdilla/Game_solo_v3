import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:game_solo_v3/core/di/di.dart';
import 'package:game_solo_v3/core/env_validator.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  EnvValidator.validate();
  await configureDependencies();
}

