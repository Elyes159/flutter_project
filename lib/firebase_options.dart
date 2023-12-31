// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC40uZr5F_hLsmDXkGiikdvf7LgK0jGqQ4',
    appId: '1:132415407815:web:514fe5f2e07e855ece20e2',
    messagingSenderId: '132415407815',
    projectId: 'flutterfire-fbaf8',
    authDomain: 'flutterfire-fbaf8.firebaseapp.com',
    storageBucket: 'flutterfire-fbaf8.appspot.com',
    measurementId: 'G-JH469NEF4X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvMbHeC3t3yguRTGwhneF4ZgXFXU4Tq1E',
    appId: '1:132415407815:android:9669f3e8521ee187ce20e2',
    messagingSenderId: '132415407815',
    projectId: 'flutterfire-fbaf8',
    storageBucket: 'flutterfire-fbaf8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKAAABWqORjxBp3ZuQK6Do_nARB9_ANxI',
    appId: '1:132415407815:ios:5799b52cc34e87a4ce20e2',
    messagingSenderId: '132415407815',
    projectId: 'flutterfire-fbaf8',
    storageBucket: 'flutterfire-fbaf8.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseFirst',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKAAABWqORjxBp3ZuQK6Do_nARB9_ANxI',
    appId: '1:132415407815:ios:e328720728cc7350ce20e2',
    messagingSenderId: '132415407815',
    projectId: 'flutterfire-fbaf8',
    storageBucket: 'flutterfire-fbaf8.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseFirst.RunnerTests',
  );
}
