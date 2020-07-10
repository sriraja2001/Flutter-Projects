import 'package:flutter/material.dart';
import 'package:restaurantapp/components/meal_item.dart';
import 'package:restaurantapp/models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favouriteMeals.isEmpty){
      return Center(
        child: Text('You have no favourites yet - start adding some!'),
      );
    }else{
      return ListView.builder(itemBuilder: (ctx, index){
        return MealItem(
          id: favouriteMeals[index].id,
          title: favouriteMeals[index].title,
          imageUrl: favouriteMeals[index].imageUrl,
          affordability: favouriteMeals[index].affordability,
          complexity: favouriteMeals[index].complexity,
          duration: favouriteMeals[index].duration,
        );
      },
        itemCount: favouriteMeals.length,);
    }
  }
}
