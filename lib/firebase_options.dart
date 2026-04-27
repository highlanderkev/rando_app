// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Returns the value injected at compile time via --dart-define (CI builds),
// or falls back to the runtime .env file (local development).
String _env(String key, String dartDefineValue) {
  if (dartDefineValue.trim().isNotEmpty) return dartDefineValue.trim();
  final value = dotenv.env[key];
  if (value == null || value.trim().isEmpty) {
    throw StateError(
      'Missing required environment variable: $key. '
      'Pass it via --dart-define=$key=VALUE or add it to .env.',
    );
  }
  return value;
}

// Optional env value; returns null if not set by either source.
String? _optionalEnv(String key, String dartDefineValue) {
  if (dartDefineValue.trim().isNotEmpty) return dartDefineValue.trim();
  return dotenv.env[key];
}

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: _env('FIREBASE_WEB_API_KEY',
            const String.fromEnvironment('FIREBASE_WEB_API_KEY')),
        appId: _env('FIREBASE_APP_ID',
            const String.fromEnvironment('FIREBASE_APP_ID')),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID',
            const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID')),
        projectId: _env('FIREBASE_PROJECT_ID',
            const String.fromEnvironment('FIREBASE_PROJECT_ID')),
        authDomain: _optionalEnv('FIREBASE_WEB_AUTH_DOMAIN',
            const String.fromEnvironment('FIREBASE_WEB_AUTH_DOMAIN')),
        storageBucket: _optionalEnv('FIREBASE_STORAGE_BUCKET',
            const String.fromEnvironment('FIREBASE_STORAGE_BUCKET')),
        measurementId: _optionalEnv('FIREBASE_WEB_MEASUREMENT_ID',
            const String.fromEnvironment('FIREBASE_WEB_MEASUREMENT_ID')),
      );

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: _env('FIREBASE_ANDROID_API_KEY',
            const String.fromEnvironment('FIREBASE_ANDROID_API_KEY')),
        appId: _env('FIREBASE_APP_ID',
            const String.fromEnvironment('FIREBASE_APP_ID')),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID',
            const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID')),
        projectId: _env('FIREBASE_PROJECT_ID',
            const String.fromEnvironment('FIREBASE_PROJECT_ID')),
        storageBucket: _optionalEnv('FIREBASE_STORAGE_BUCKET',
            const String.fromEnvironment('FIREBASE_STORAGE_BUCKET')),
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: _env('FIREBASE_IOS_API_KEY',
            const String.fromEnvironment('FIREBASE_IOS_API_KEY')),
        appId: _env('FIREBASE_APP_ID',
            const String.fromEnvironment('FIREBASE_APP_ID')),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID',
            const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID')),
        projectId: _env('FIREBASE_PROJECT_ID',
            const String.fromEnvironment('FIREBASE_PROJECT_ID')),
        storageBucket: _optionalEnv('FIREBASE_STORAGE_BUCKET',
            const String.fromEnvironment('FIREBASE_STORAGE_BUCKET')),
        iosClientId: _optionalEnv('FIREBASE_IOS_CLIENT_ID',
            const String.fromEnvironment('FIREBASE_IOS_CLIENT_ID')),
        iosBundleId: _optionalEnv('FIREBASE_IOS_BUNDLE_ID',
            const String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID')),
      );

  static FirebaseOptions get macos => FirebaseOptions(
        apiKey: _env('FIREBASE_IOS_API_KEY',
            const String.fromEnvironment('FIREBASE_IOS_API_KEY')),
        appId: _env('FIREBASE_APP_ID',
            const String.fromEnvironment('FIREBASE_APP_ID')),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID',
            const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID')),
        projectId: _env('FIREBASE_PROJECT_ID',
            const String.fromEnvironment('FIREBASE_PROJECT_ID')),
        storageBucket: _optionalEnv('FIREBASE_STORAGE_BUCKET',
            const String.fromEnvironment('FIREBASE_STORAGE_BUCKET')),
        iosClientId: _optionalEnv('FIREBASE_MACOS_CLIENT_ID',
            const String.fromEnvironment('FIREBASE_MACOS_CLIENT_ID')),
        iosBundleId: _optionalEnv('FIREBASE_MACOS_BUNDLE_ID',
            const String.fromEnvironment('FIREBASE_MACOS_BUNDLE_ID')),
      );
}
