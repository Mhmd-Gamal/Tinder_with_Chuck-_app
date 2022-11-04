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
    apiKey: 'AIzaSyAhW-Gu0Ju6L5WmlPLEqyH5ewCio3HhYIk',
    appId: '1:317914413653:web:43f207d13873fd853b32dc',
    messagingSenderId: '317914413653',
    projectId: 'chuck-norris-d1202',
    authDomain: 'chuck-norris-d1202.firebaseapp.com',
    storageBucket: 'chuck-norris-d1202.appspot.com',
    measurementId: 'G-WXLRZ7GLPW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwRqxoptD5y89msC_4pxcJsCfu0jyE5aI',
    appId: '1:317914413653:android:57dd68d5a97177083b32dc',
    messagingSenderId: '317914413653',
    projectId: 'chuck-norris-d1202',
    storageBucket: 'chuck-norris-d1202.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9nAlF2jN4zh0ba43EiShKGLJcYjEsgFc',
    appId: '1:317914413653:ios:615f1b29c40ac4613b32dc',
    messagingSenderId: '317914413653',
    projectId: 'chuck-norris-d1202',
    storageBucket: 'chuck-norris-d1202.appspot.com',
    iosClientId: '317914413653-1fdspvckoe4iqt3m8hneh4q0b2rn0vac.apps.googleusercontent.com',
    iosBundleId: 'com.chucknorris.chucknorrisApp',
  );
}