import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/recipe.dart';
import 'package:flutter_application_1/rng.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Roulette',
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

  Future<void> _getRecipes() async {
    //final List<String> fetchedData = Recipe.fetchRecipes();

    //for (var item in fetchedData) {
    //_recipeList.add(Recipe.convertJson(item));
    //}

    await loadRecipes();
    //loadToFB(_fullList);
    _selectFour();
  }

  Future<void> loadRecipes() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("recipes")
        .doc('08C60Ww7RIthTZDS4BY3')
        .get()
        .then((value) => {
              print(Recipe(
                      name: value['name'],
                      description: value['description'],
                      imagePath: value['imagePath'])
                  .name)
            })
        /* .then((value) => {
              for (var item in value.docs)
                {
                  print(item.toString()),
                  _fullList.add(Recipe(
                      name: item['name'],
                      description: item['description'],
                      imagePath: item['imagePath']))
                },
            }) */
        .catchError((onError) => print(onError));
  }

  Future<void> startFB() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future loadToFB(List<Recipe> myRecipes) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    for (var item in myRecipes) {
      final recipe = <String, dynamic>{
        "name": item.name,
        "description": item.description,
        "imagePath": item.imagePath
      };
      db
          .collection("recipes")
          .add(recipe)
          .then((value) => print("done"))
          .catchError((onError) => print(onError));
    }
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
                  _recipeList[index].name!,
                  style: _biggerFont,
                ),
                leading: Image.asset(_recipeList[index].imagePath!),
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
                title: Text(choice.name!),
              ),
              body: Container(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  choice.description!,
                  style: _biggerFont,
                ),
              ));
        },
      ),
    );
  }
}
