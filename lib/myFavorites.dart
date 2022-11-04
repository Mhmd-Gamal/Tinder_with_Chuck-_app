import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'elements.dart';

import 'jokes.dart';

class FavoritesScreen extends StatelessWidget {
  Box box;

  FavoritesScreen(this.box);

  @override
  Widget build(BuildContext context) {
    //TODO: Move the builder method to another class?

    //Getting the list of favorite Jokes from hive
    List<dynamic> boxContent = box.get('jokes', defaultValue: <Jokes>[]);
    List<Jokes> jokesList = List<Jokes>.from(boxContent);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 141, 63, 46),
          toolbarHeight: 55,
          title: Text('My Favorite Jokes'),
        ),
        body: jokesList.length == 0
            ? Center(
                child: Text('My favorites list is empty'),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Jokes currentItem = jokesList[index];

                  return Elements(currentItem.value!);
                },
                itemCount: jokesList.length,
              ));
  }
}
