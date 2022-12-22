import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'elements.dart';

import 'jokes.dart';

class FavoritesScreen extends StatelessWidget {
  final Box box;

  const FavoritesScreen({Key? key, required this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Getting the list of favorite Jokes from hive
    List<dynamic> boxContent = box.get('jokes', defaultValue: <Jokes>[]);
    List<Jokes> jokesList = List<Jokes>.from(boxContent);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 141, 63, 46),
          toolbarHeight: 55,
          title: const Text('My Favorite Jokes'),
        ),
        body: jokesList.isEmpty
            ? const Center(
                child: Text('My favorites list is empty'),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Jokes currentItem = jokesList[index];

                  return Elements(value: currentItem.value!);
                },
                itemCount: jokesList.length,
              ));
  }
}
