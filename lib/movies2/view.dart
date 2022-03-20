import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies2/controller.dart';
import 'package:movie_app/movies2/states.dart';
import 'package:movie_app/movies2/widgets/gird_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviesScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesController2()..getData(),
      child: BlocConsumer<MoviesController2, MoviesStates2>(
        listener: (context, state) {},
        builder: (context, state) {
          final controller = MoviesController2.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('MoviesApp'),
              centerTitle: true,
            ),
            body: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.refresh,
              onLoading: controller.loading,
              enablePullUp: true,
              enablePullDown: true,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(controller.movies!.length,
                    (index) => GirdItems(controller.movies!, index)),
              ),
            ),
          );
        },
      ),
    );
  }
}
