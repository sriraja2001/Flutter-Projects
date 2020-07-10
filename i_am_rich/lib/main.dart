import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("I am Rich"),
            backgroundColor: Colors.blueGrey[900],
          ),
          backgroundColor: Colors.blueGrey,
          body: Center(
            child: Image(
              image: NetworkImage(
                  "https://c4.wallpaperflare.com/wallpaper/73/812/41/tom-ellis-lucifer-season-3-tv-series-4k-wallpaper-preview.jpg")
            ),
          ),
      ),
    ),
  );
}
