import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String? name;
  final String? description;
  final String? imagePath;

  Recipe({this.name, this.description, this.imagePath});

  factory Recipe.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Recipe(
        name: data?['name'],
        description: data?['description'],
        imagePath: data?['imagePath']);
  }

  static List<Recipe> fetchRecipes() {
    const String loremIpsum =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
    const String imageAdress = 'lib/img/chat_up.png';

    List<Recipe> recipeList = [
      Recipe(name: 'Pasta', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Chicken', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Lasagne', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Soup', description: loremIpsum, imagePath: imageAdress),
      Recipe(
          name: 'Ice Cream', description: loremIpsum, imagePath: imageAdress),
      Recipe(
          name: 'Meatballs', description: loremIpsum, imagePath: imageAdress),
/*       Recipe(name: 'Goulash', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Rice', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Sushi', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Sallad', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Pizza', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Curry', description: loremIpsum, imagePath: imageAdress), */
    ];
    return recipeList;
  }
}
