import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies2/model.dart';
import 'package:movie_app/movies2/states.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviesController2 extends Cubit<MoviesStates2> {
  List<Results>? movies = [];
  List<Results>? newMovies = [];
  int pageNumber = 1;

  MoviesController2() : super(InitialState());

  static MoviesController2 get(context) => BlocProvider.of(context);
  RefreshController refreshController = RefreshController();

  getData() async {
    newMovies!.clear();
    var response = await Dio().get(
        "https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&page=$pageNumber");
    MoviesModel model = MoviesModel.fromJson(response.data);
    newMovies = model.results;
    movies!.addAll(newMovies!);
    emit(GetMoviesSucsessState());
  }

  loading() {
    pageNumber++;
    getData();
    refreshController.loadComplete();
    emit(LoadingState());
  }

  refresh() {
    pageNumber = 1;
    movies!.clear();
    getData();
    refreshController.refreshCompleted();
    emit(RefreshState());
  }
}
