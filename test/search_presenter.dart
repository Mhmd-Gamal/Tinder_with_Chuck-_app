import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project2/AdditionalFiles/global_methods.dart';
import 'searchpage.dart';
import '../lib/AdditionalFiles/global_methods.dart';


import '../lib/Model/Joke.dart';

class SearchPresenter {
  BuildContext context;
  late SearchPageState view;

  SearchPresenter(this.context, this.view);

  Future<List<Joke>> searchJokes(String input) async{

    view.updateSearchStarted(true);

    List<Joke> jokesList = <Joke> [];

    String url = 'https://api.chucknorris.io/jokes/search?query=$input';

      Future<List<Joke>> fetchJson() async {
        try {

          var response = await Dio().get(url);
          final decodedJson = jsonDecode(response.toString());
          int count = decodedJson['total'] as int;

          for(int i = 0; i < count; i++){
            var currentJokeJson = decodedJson['result'][i];
            Joke joke = Joke.fromJson(currentJokeJson);
            jokesList.add(joke);
          }
          return jokesList;
        } catch(e){
          print(e);
          return <Joke> [];
        }
      }

      bool isOnline = await hasNetwork(context);

      if(isOnline){
        return fetchJson();
      } else {
        onNetworkMissed(context);
        return <Joke> [];
      }
  }

}

//Abstract class with functions we will need to connect with the view
abstract class SearchView {
updateSearchStarted(bool b);
}