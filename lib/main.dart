import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        hintColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodySmall: const TextStyle(
                color: Color.fromARGB(255, 61, 61, 61),
              ),
              bodyMedium: const TextStyle(
                color: Colors.black,
              ),
              bodyLarge: const TextStyle(
                color: Colors.black,
              ),
              titleSmall: const TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontStyle: FontStyle.italic,
              ),
              titleMedium: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.normal,
              ),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Realway',
            fontWeight: FontWeight.w300,
          ),
          centerTitle: true,
          shape: Border(
            bottom: BorderSide(
              color: Colors.pinkAccent,
              width: 2,
            ),
          ),
        ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => CategoriesScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(),
      },
    );
  }
}
