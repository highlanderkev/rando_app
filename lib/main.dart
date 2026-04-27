import 'dart:io' show FileSystemException;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rando_app/src/auth/auth_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';

import 'src/app.dart';
import 'src/auth/auth_service.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

bool _hasEnv(String key, String dartDefineValue) {
  if (dartDefineValue.trim().isNotEmpty) return true;
  final v = dotenv.env[key];
  return v != null && v.trim().isNotEmpty;
}

void _validateFirebaseEnv() {
  // Config is injected at compile time via --dart-define (CI) or read at
  // runtime from .env (local development). Check both sources for each key.
  final missing = <String>[];

  if (!_hasEnv('FIREBASE_APP_ID',
      const String.fromEnvironment('FIREBASE_APP_ID'))) {
    missing.add('FIREBASE_APP_ID');
  }
  if (!_hasEnv('FIREBASE_MESSAGING_SENDER_ID',
      const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'))) {
    missing.add('FIREBASE_MESSAGING_SENDER_ID');
  }
  if (!_hasEnv('FIREBASE_PROJECT_ID',
      const String.fromEnvironment('FIREBASE_PROJECT_ID'))) {
    missing.add('FIREBASE_PROJECT_ID');
  }

  if (kIsWeb) {
    if (!_hasEnv('FIREBASE_WEB_API_KEY',
        const String.fromEnvironment('FIREBASE_WEB_API_KEY'))) {
      missing.add('FIREBASE_WEB_API_KEY');
    }
  } else {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (!_hasEnv('FIREBASE_ANDROID_API_KEY',
            const String.fromEnvironment('FIREBASE_ANDROID_API_KEY'))) {
          missing.add('FIREBASE_ANDROID_API_KEY');
        }
        break;
      case TargetPlatform.iOS:
        if (!_hasEnv('FIREBASE_IOS_API_KEY',
            const String.fromEnvironment('FIREBASE_IOS_API_KEY'))) {
          missing.add('FIREBASE_IOS_API_KEY');
        }
        break;
      default:
        break;
    }
  }

  if (missing.isNotEmpty) {
    throw StateError(
      'Missing required Firebase environment variables: ${missing.join(', ')}. '
      'Pass them via --dart-define or add them to .env.',
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load .env for local development. In CI builds secrets are injected via
  // --dart-define so the file may not exist; silently skip in that case.
  try {
    await dotenv.load(fileName: '.env');
  } on FileSystemException {
    // .env absent – configuration will come from --dart-define values.
  }
  _validateFirebaseEnv();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  final authController = AuthController(AuthService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(
      settingsController: settingsController, authController: authController));
}
