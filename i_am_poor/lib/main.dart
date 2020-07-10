import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('I am Poor')
      ) ,
      body: Center(
        child: Image(
          image: AssetImage("images/coal-png-clip-art.png"),
        ),
      )
    ),
  ));
}
