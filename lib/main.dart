import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/screens/unknown_route_screen.dart';

import 'package:meals/screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _avaliableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _avaliableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten =
            settings.isGlutenFree == true && !meal.isGlutenFree;
        final filterLactose =
            settings.isLactoseFree == true && !meal.isLactoseFree;
        final filterVegan = settings.isVegan == true && !meal.isVegan;
        final filterVegetarian =
            settings.isVegetarian == true && !meal.isVegetarian;
        return !(filterGluten ||
            filterLactose ||
            filterVegan ||
            filterVegetarian);
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        primaryColor: Colors.pink,
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
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 30,
            )),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.pink,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amber,
        ),
        drawerTheme: const DrawerThemeData(),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          splashColor: Colors.pink,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.white12;
            },
          ),
          trackColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.green;
              }
              return Colors.black12;
            },
          ),
          trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.green;
              }
              return Colors.white12;
            },
          ),
        ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(_avaliableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(settings, _filterMeals),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const UnknownRouteScreen(),
        );
      },
    );
  }
}
