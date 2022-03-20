import 'package:flutter/material.dart';

import '../model.dart';

class ItemGrid extends StatelessWidget {
  List<Movies> movies;
  int index;
  ItemGrid(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        child: Image.network(
          movies[index].posterPath != null
              ? 'https://image.tmdb.org/t/p/original/${movies[index].posterPath}'
              : 'http://mollagri.com/uploads/images/No_Image_Available1.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
