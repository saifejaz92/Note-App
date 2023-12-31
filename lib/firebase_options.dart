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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA1Tc9mXuYvYo0JK6TO_Xt7wn9xxLi9Kzo',
    appId: '1:1025434706507:web:10f5a4661b288eb4d723ce',
    messagingSenderId: '1025434706507',
    projectId: 'mynewyesthework',
    authDomain: 'mynewyesthework.firebaseapp.com',
    storageBucket: 'mynewyesthework.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXXZp1qJMBlY62oCTNGOPZVqKO5y4QPSM',
    appId: '1:1025434706507:android:fc195b6da33765d7d723ce',
    messagingSenderId: '1025434706507',
    projectId: 'mynewyesthework',
    storageBucket: 'mynewyesthework.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwfVT8tUhXpwOm6UtfsvrBpVs25WPe9dY',
    appId: '1:1025434706507:ios:963e876243c2ea29d723ce',
    messagingSenderId: '1025434706507',
    projectId: 'mynewyesthework',
    storageBucket: 'mynewyesthework.appspot.com',
    iosBundleId: 'com.example.noteApp',
  );
}
