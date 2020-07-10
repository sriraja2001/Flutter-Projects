import 'package:flutter/material.dart';
import 'package:restaurantapp/components/category_item.dart';
import 'package:restaurantapp/dummy_data.dart';
import '../components/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView(
          children: DUMMY_CATEGORIES.map((catData) => CategoryItem(catData.title,catData.color,catData.id)).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
        ),
      );
  }
}
