import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/states.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'model.dart';

class MoviesController extends Cubit<MovieStates> {
  MoviesController() : super(InitialState());

  static MoviesController get(context) => BlocProvider.of(context);

  var searchController = TextEditingController();
  List<Movies>? moviesSearchResult = [];
  void search(String word){
    moviesSearchResult!.clear();
    for(int i =0; i<movies!.length;i++){
      if(movies![i].title.startsWith(word)||movies![i].title.startsWith(word.toUpperCase())){
        moviesSearchResult!.add(movies![i]);
      }
    }
    print(moviesSearchResult!.length);
    emit(SearchState());
  }

  RefreshController refreshController = RefreshController();
  List<Movies>? movies = [];
  List<Movies>? newMovies = [];
  int pageNumber = 1;

  getData() async {
    newMovies!.clear();
    var response = await Dio().get(
        "https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&page=$pageNumber");
    MovieModel model = MovieModel.fromJson(response.data);
    newMovies = model.movies;
    movies!.addAll(newMovies!);
    print("newMovies:" + newMovies!.length.toString());
    print(" movies:" + movies!.length.toString());
    emit(GetMoviesSuccessState());
  }

  refresh() {
    pageNumber = 1;
    movies!.clear();
    getData();
    refreshController.refreshCompleted();
    emit(RefreshState());
  }

  loading() {
    pageNumber++;
    getData();
    refreshController.loadComplete();
    emit(LoadingState());
  }



  bool isOnline = true;

  getInternetConnection() {
    Connectivity c = Connectivity();
    var stream = c.onConnectivityChanged;
    stream.listen((ConnectivityResult event) {
      if (event == ConnectivityResult.none) {
        print('no internet');
        isOnline = false;
      } else if (event == ConnectivityResult.mobile) {
        print('internet with data');
        isOnline = true;
      } else {
        print('internet with wifi');
        isOnline = true;
      }
      emit(InternetState());
    });
  }
}
