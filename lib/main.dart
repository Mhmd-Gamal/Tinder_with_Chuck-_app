// @dart=2.9

import 'package:flutter/material.dart';
import 'jokes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  runApp(const ChuckNorris());
}

class ChuckNorris extends StatefulWidget {
  const ChuckNorris({Key key}) : super(key: key);

  @override
  ChuckNorrisState createState() => ChuckNorrisState();
}

class ChuckNorrisState extends State<ChuckNorris> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(box: box),
    );
  }
}
