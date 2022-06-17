import 'dart:convert';
import 'dart:developer';

class Recipe {
  Recipe(
      {required this.name, required this.description, required this.imagePath});

  final String name;
  final String description;
  final String imagePath;

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
      Recipe(name: 'Goulash', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Rice', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Sushi', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Sallad', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Pizza', description: loremIpsum, imagePath: imageAdress),
      Recipe(name: 'Curry', description: loremIpsum, imagePath: imageAdress),
    ];
    return recipeList;
  }
}
