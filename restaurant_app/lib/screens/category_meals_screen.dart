import 'package:flutter/material.dart';
import 'package:restaurantapp/components/meal_item.dart';
import 'package:restaurantapp/dummy_data.dart';
import 'package:restaurantapp/models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  List<Meal> displayedMeals;
  String categoryTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    categoryTitle = routeArgs['title'];
    final String categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal){
      return meal.categories.contains(categoryId);
    }).toList();
  }

  void removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(itemBuilder: (ctx, index){
        return MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          imageUrl: displayedMeals[index].imageUrl,
          affordability: displayedMeals[index].affordability,
          complexity: displayedMeals[index].complexity,
          duration: displayedMeals[index].duration,
        );
      },
      itemCount: displayedMeals.length,)
    );
  }
}
