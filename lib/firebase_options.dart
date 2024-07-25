// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDq0GimG2BM6dkr4lb2wO2b9wRsL_-gJs0',
    appId: '1:187636420985:web:09c7cc63cad241c8149fa8',
    messagingSenderId: '187636420985',
    projectId: 'tts09bf',
    authDomain: 'tts09bf.firebaseapp.com',
    storageBucket: 'tts09bf.appspot.com',
    measurementId: 'G-ZWM6YV2H49',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNw5_oW0m9bAUv38NWFbL0NyH-IbRvI0E',
    appId: '1:187636420985:android:b303c4460766c07f149fa8',
    messagingSenderId: '187636420985',
    projectId: 'tts09bf',
    storageBucket: 'tts09bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0svpgJ-MejZhLL2KaDM-dtJHDiVyY9qQ',
    appId: '1:187636420985:ios:08784b19d8c615b4149fa8',
    messagingSenderId: '187636420985',
    projectId: 'tts09bf',
    storageBucket: 'tts09bf.appspot.com',
    iosBundleId: 'com.example.tts09bf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0svpgJ-MejZhLL2KaDM-dtJHDiVyY9qQ',
    appId: '1:187636420985:ios:08784b19d8c615b4149fa8',
    messagingSenderId: '187636420985',
    projectId: 'tts09bf',
    storageBucket: 'tts09bf.appspot.com',
    iosBundleId: 'com.example.tts09bf',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDq0GimG2BM6dkr4lb2wO2b9wRsL_-gJs0',
    appId: '1:187636420985:web:8ec36f19f15af31a149fa8',
    messagingSenderId: '187636420985',
    projectId: 'tts09bf',
    authDomain: 'tts09bf.firebaseapp.com',
    storageBucket: 'tts09bf.appspot.com',
    measurementId: 'G-L5R81L0XKV',
  );
}
