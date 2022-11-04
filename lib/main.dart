// @dart=2.9

/*
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project2/Model/Joke.dart';

import 'View/home.dart';
import 'firebase_options.dart';

Box box;

void main() async {
  //Initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Initialize hive
  await Hive.initFlutter();

  Hive.registerAdapter(JokeAdapter());

  box = await Hive.openBox('box');

  // Pass all uncaught errors from the framework to Firebase Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  //Running the app
  runApp(ChuckNorrisProject());
}

class ChuckNorrisProject extends StatefulWidget {
  @override
  ChuckNorrisProjectState createState() => ChuckNorrisProjectState();
}

class ChuckNorrisProjectState extends State<ChuckNorrisProject> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(box),
    );
  }
}
*/





// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'jokes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'home.dart';
import 'firebase_options.dart';

Box box;

void main() async {
  //Initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Initialize hive
  await Hive.initFlutter();

  Hive.registerAdapter(JokeAdapter());

  box = await Hive.openBox('box');

  // Pass all uncaught errors from the framework to Firebase Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  //Running the app
  // ignore: prefer_const_constructors
  runApp(ChuckNorris());
}

class ChuckNorris extends StatefulWidget {
  @override
  ChuckNorrisState createState() => ChuckNorrisState();
}

class ChuckNorrisState extends State<ChuckNorris> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(box),
    );
  }
}
