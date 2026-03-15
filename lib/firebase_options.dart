// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String _requiredEnv(String key) {
  final value = dotenv.env[key];
  if (value == null || value.trim().isEmpty) {
    throw StateError('Missing required environment variable: $key');
  }
  return value;
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
        apiKey: _requiredEnv('FIREBASE_WEB_API_KEY'),
        appId: _requiredEnv('FIREBASE_APP_ID'),
        messagingSenderId: _requiredEnv('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _requiredEnv('FIREBASE_PROJECT_ID'),
        authDomain: dotenv.env['FIREBASE_WEB_AUTH_DOMAIN'],
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
        measurementId: dotenv.env['FIREBASE_WEB_MEASUREMENT_ID'],
      );

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: _requiredEnv('FIREBASE_ANDROID_API_KEY'),
        appId: _requiredEnv('FIREBASE_APP_ID'),
        messagingSenderId: _requiredEnv('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _requiredEnv('FIREBASE_PROJECT_ID'),
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: _requiredEnv('FIREBASE_IOS_API_KEY'),
        appId: _requiredEnv('FIREBASE_APP_ID'),
        messagingSenderId: _requiredEnv('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _requiredEnv('FIREBASE_PROJECT_ID'),
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
        iosClientId: dotenv.env['FIREBASE_IOS_CLIENT_ID'],
        iosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID'],
      );

  static FirebaseOptions get macos => FirebaseOptions(
        apiKey: _requiredEnv('FIREBASE_IOS_API_KEY'),
        appId: _requiredEnv('FIREBASE_APP_ID'),
        messagingSenderId: _requiredEnv('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _requiredEnv('FIREBASE_PROJECT_ID'),
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
        iosClientId: dotenv.env['FIREBASE_MACOS_CLIENT_ID'],
        iosBundleId: dotenv.env['FIREBASE_MACOS_BUNDLE_ID'],
      );
}
