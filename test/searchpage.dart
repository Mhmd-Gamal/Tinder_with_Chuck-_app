import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/Presenter/home_presenter.dart';
import 'search_presenter.dart';

import '../lib/Model/Joke.dart';
import 'search_presenter.dart';
import '../lib/Widgets/joke_item.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> implements SearchView {
  final controller = TextEditingController();
  late SearchPresenter presenter;
  bool searchStarted = false;

  @override
  updateSearchStarted(bool b) {
    setState(() {
      searchStarted = b;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter = SearchPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Jokes'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "Enter Text",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Search'),
          ),
          FutureBuilder(
            //TODO: Modify
            future: presenter.searchJokes('food'),
            builder: (context, snapshot) {
              if (searchStarted &&
                      snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  strokeWidth: 8,
                );
              }

              return ListView.builder(
                itemCount: (snapshot as List).length,
                itemBuilder: (BuildContext context, int index) {
                  Joke joke = (snapshot as List)[index];

                  return JokeItem(joke.value!);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
