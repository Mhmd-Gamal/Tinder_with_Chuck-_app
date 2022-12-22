// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'my_favorites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'jokes.dart';

/// ===========================================================================

Future<bool> hasNetwork(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

void onNetworkMissed(BuildContext context) {
  ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      content: Text(
          'Failed to connect to network. Please connect to the Internet then try again'),
      backgroundColor: Colors.grey,
      actions: [
        TextButton(
          child: Text('DISMISS'),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
        ),
      ]));
}

/// ===========================================================================
class PrepJoke {
  BuildContext context;
  late HomePageState Show;
  Jokes joke = Jokes();
  Box box;

  // Constructor which takes context and the Show
  PrepJoke(this.context, this.Show, this.box);

  // Get a random joke and fetch the json into a joke object
  void get_joke(String category, bool initialJoke) async {
    bool isOnline = await hasNetwork(context);
    String url;

    if (category == "All categories") {
      url = 'https://api.chucknorris.io/jokes/random';
    } else {
      url = 'https://api.chucknorris.io/jokes/random?category=$category';
    }

    // collect the Joke from the API

    void collect_joke() async {
      try {
        var response = await Dio().get(url);
        joke = Jokes.fromJson(jsonDecode(response.toString()));
        Show.text_update(joke.value!, joke.url!, joke.iconUrl!);
      } catch (e) {
        //print(e);
      }
    }

    if (isOnline) {
      collect_joke();
    } else {
      onNetworkMissed(context);
    }

    if (initialJoke) {
      FlutterNativeSplash.remove();
    }
  }

  //void show_in_browser() => Show.goto_url('Show Joke');
  void show_in_browser() async {
    bool isOnline = await hasNetwork(context);

    if (isOnline) {
      if (joke.value == null || joke.value == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please Load a joke first by pressing Like button'),
          ),
        );
        return;
      }

      goto_url('Show Joke');
    } else {
      onNetworkMissed(context);
    }
  }

  //void ShowPhotos() => Show.goto_url('Show Photos');
  void showPhotos() async {
    bool isOnline = await hasNetwork(context);
    if (isOnline) {
      if (joke.value == null || joke.value == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please Load a joke first by pressing Like button'),
          ),
        );
        return;
      }

      goto_url('Show Photos');
    } else {
      onNetworkMissed(context);
    }
  }

  void directToFavourites() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FavoritesScreen(box: box)));
  }

  void add_favorites() async {
    bool isOnline = await hasNetwork(context);
    if (isOnline) {
      if (joke.value == null || joke.value == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please Load a joke first by pressing Like button'),
          ),
        );
        return;
      }

      // Adding the joke to hive
      List<dynamic> boxContent = box.get('jokes', defaultValue: <Jokes>[]);
      List<Jokes> jokesList = List<Jokes>.from(boxContent);
      jokesList.add(joke);
      box.put('jokes', jokesList);

      //favoriteJokes.add(joke);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Added to favorites"),
      ));

      //Adding the joke to firebase
      final db = FirebaseFirestore.instance;
      db.collection("favorites").add(joke.toJson());
    } else {
      onNetworkMissed(context);
    }
  }

  //@override
  void goto_url(String type) {
    //Open related images of the joke on chrome
    if (type == 'Show Photos') {
      String jokeContent = joke.value!.replaceAll(' ', '+');
      String photosUrl =
          'https://www.google.com/search?q=$jokeContent&tbm=isch';

      url_launcher.launchUrl(Uri.parse(photosUrl));
    }
    // Show the joke on the website
    else if (type == 'Show Joke') {
      url_launcher.launchUrl(Uri.parse(joke.url!));
    }
  }
}

//Abstract class to connect with the Show
abstract class Show {
  void text_update(String value, String joke_url, String imageUrl);
}
// ===========================================================================

late PrepJoke viewer;

class HomePage extends StatefulWidget {
  final Box box;

  const HomePage({Key? key, required this.box}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  HomePageState createState() => HomePageState(box);
}

class HomePageState extends State<HomePage> implements Show {
  late String joke_val = '';
  late String joke_url = '';
  late String img_url = '';
  late final Box box;
  final cat_list = [
    "All categories",
    "animal",
    "career",
    "celebrity",
    "dev",
    "explicit",
    "fashion",
    "food",
    "history",
    "money",
    "movie",
    "music",
    "political",
    "religion",
    "science",
    "sport",
    "travel"
  ];
  //HomePageState(Box box);

  String? curr_cat = "All categories";

  HomePageState(this.box);
  @override
  void initState() {
    bool initialJoke = true;

    super.initState();

    // Initializing an instance of the constructor
    viewer = PrepJoke(context, this, box);

    //Getting the first joke from the API
    viewer.get_joke(cat_list[0], initialJoke);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 141, 63, 46),
          toolbarHeight: 55,
          title: const Text('Tinder with Chuck Norris'),
        ),
        drawer: Navigation(),
        body: Center(
            child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://d50-a.sdn.cz/d_50/c_img_E_G/Q18EK/chuck-norris.jpeg"),
                fit: BoxFit.cover),
          ),
          child: SizedBox(
            width: 1000,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        iconEnabledColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        value: curr_cat,
                        items: cat_list
                            .map<DropdownMenuItem<String>>((String value) =>
                                DropdownMenuItem<String>(
                                    value:
                                        value, // add this property an pass the _value to it
                                    child: Text(
                                      value,
                                    )))
                            .toList(),
                        onChanged: (category) {
                          setState(() {
                            curr_cat = category!;
                          });
                          viewer.get_joke(category!, false);
                        },
                        isExpanded: true,
                        iconSize: 36,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7.8, 7.8, 7.8, 70.0),
                    child: Text(
                      joke_val,
                      style: TextStyle(
                        fontSize: 20.0,
                        foreground: Paint()..color = Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(1),
                      child: ElevatedButton(
                        onPressed: () => viewer.get_joke(curr_cat!, false),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(150.0, 35.0)),
                        child: const Text('Switch'),
                      )),
                  Container(
                      margin: EdgeInsets.all(1),
                      child: ElevatedButton(
                        onPressed: viewer.showPhotos,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(150.0, 35.0)),
                        child: const Text('Related Images'),
                      )),
                  Container(
                      margin: EdgeInsets.all(1),
                      child: ElevatedButton(
                        onPressed: viewer.show_in_browser,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(150.0, 35.0)),
                        child: const Text('Show in Browser'),
                      )),
                  Container(
                      margin: EdgeInsets.all(1),
                      child: ElevatedButton(
                        onPressed: viewer.add_favorites,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(150.0, 35.0)),
                        child: const Text('Add to My Favorites'),
                      ))
                ],
              ),
            ),
          ),
        )));
  }

  // change the text aftr updating the joke
  @override
  void text_update(String value, url, imageUrl) {
    setState(() {
      joke_val = value;
      joke_url = url;
      img_url = imageUrl;
    });
  }
}

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/app_icon.png'))),
            ),
            ListTile(
              leading: Icon(Icons.wysiwyg_rounded),
              title: Text('My Favorite Jokes'),
              onTap: () => {viewer.directToFavourites()},
            ),
          ],
        ),
      ),
    );
  }
}
