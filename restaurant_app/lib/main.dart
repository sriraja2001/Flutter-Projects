import 'package:flutter/material.dart';
import 'package:restaurantapp/dummy_data.dart';
import 'package:restaurantapp/models/meal.dart';
import 'package:restaurantapp/screens/category_meals_screen.dart';
import 'package:restaurantapp/screens/filters_screen.dart';
import 'package:restaurantapp/screens/meal_detail_screen.dart';
import 'package:restaurantapp/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  @override
  Widget build(BuildContext context) {

    void _setFilters(Map<String, bool> filterData){
      setState(() {
        _filters = filterData;
        _availableMeals = DUMMY_MEALS.where((meal){
          if(_filters['gluten'] && !meal.isGlutenFree){
            return false;
          }
          if(_filters['lactose'] && !meal.isLactoseFree){
            return false;
          }
          if(_filters['vegan'] && !meal.isVegan){
            return false;
          }
          if(_filters['vegetarian'] && !meal.isVegetarian){
            return false;
          }else{
            return true;
          }
        }).toList();
      });
    }

    void _toggleFavourite(String mealId){
      final existingIndex =_favouriteMeals.indexWhere((meal) => meal.id == mealId);
      if(existingIndex>=0){
        setState(() {
          _favouriteMeals.removeAt(existingIndex);
        });
      }else{
        setState(() {
          _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
        });
      }
    }

    bool _isMealFavourite(String id){
      return _favouriteMeals.any((meal) => meal.id == id);
    }

    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6 : TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/' : (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FilterScreen.routeName : (ctx) =>FilterScreen(_setFilters, _filters),
      },
    );
  }
}


