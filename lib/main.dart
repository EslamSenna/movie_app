import 'package:flutter/material.dart';

import 'movies/view.dart';
import 'movies2/view.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: PageView(
        children: [
          //MoviesScreen2(),
          MoviesScreen(),


        ],
      ),
    );
  }
}


