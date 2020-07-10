import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product({@required this.id, @required this.title, @required this.description, @required this.price, @required this.imageUrl, this.isFavourite = false});

  void toggleFavouriteStatus(){
    isFavourite = !isFavourite;
    notifyListeners();
  }
}