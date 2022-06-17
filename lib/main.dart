import 'dart:html';
import 'dart:js';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:convert';

import 'package:flutter_application_1/recipe.dart';
import 'package:flutter_application_1/rng.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup name generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RecipeView(),
    );
  }
}

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final _recipeList = <Recipe>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _fullList = <Recipe>[];
  final _alreadySelected = <Recipe>[];

  void _getRecipes() {
    //final List<String> fetchedData = Recipe.fetchRecipes();

    //for (var item in fetchedData) {
    //_recipeList.add(Recipe.convertJson(item));
    //}

    _fullList.addAll(Recipe.fetchRecipes());
    _selectFour();
  }

  void _selectFour() {
    _recipeList.clear();

    for (var i = 0; i < 4; i++) {
      var rand = Rng.random(0, _fullList.length - 1);
      _alreadySelected.add(_fullList[rand]);
      _recipeList.add(_fullList[rand]);
      _fullList.removeAt(rand);
    }
    if (_fullList.length <= 4) {
      _fullList.addAll(_alreadySelected);
      _alreadySelected.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Roulette'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _selectFour();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView.builder(
          itemCount: 8,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            if (_recipeList.isEmpty) {
              _getRecipes();
            }

            final index = i ~/ 2;
            if (index >= 4) {}
            return ListTile(
                title: Text(
                  _recipeList[index].name,
                  style: _biggerFont,
                ),
                leading: Image.asset(_recipeList[index].imagePath),
                onTap: () {
                  _openRecipe(_recipeList[index]);
                });
          }),
    );
  }

  void _openRecipe(Recipe choice) {
    Navigator.of(this.context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(choice.name),
              ),
              body: Container(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  choice.description,
                  style: _biggerFont,
                ),
              ));
        },
      ),
    );
  }
}
