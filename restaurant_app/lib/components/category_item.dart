import 'package:flutter/material.dart';
import 'package:restaurantapp/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String categoryID;

  CategoryItem(this.title, this.color, this.categoryID);

  void selectCategory(BuildContext ctx) {
    Navigator.pushNamed(ctx, CategoryMealsScreen.routeName, arguments: {'id' : categoryID, 'title' : title });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){selectCategory(context);},
      splashColor: color,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6.copyWith(
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.5),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
