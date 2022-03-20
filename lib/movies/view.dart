import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/states.dart';
import 'package:movie_app/movies/widgets/item_grid.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'controller.dart';

class MoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesController()
        ..getData()
        ..getInternetConnection(),
      child: BlocConsumer<MoviesController, MovieStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final controller = MoviesController.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: TextFormField(
              onChanged: controller.search,
              controller: controller.searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter search word',
              ),
            ),),
              body: controller.isOnline && controller.movies!.length > 0
                  ? SmartRefresher(
                    onRefresh: controller.refresh,
                    onLoading: controller.loading,
                    controller: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(
                          controller.moviesSearchResult!.length > 0
                              ? controller.moviesSearchResult!.length
                              : controller.movies!.length,
                          (index) => ItemGrid(
                              controller.moviesSearchResult!.length >
                                      0
                                  ? controller.moviesSearchResult!
                                  : controller.movies!,
                              index)),
                    ),
                  )
                  : Center(child: CircularProgressIndicator(),
                    ));
        },
      ),
    );
  }
}
