
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

class MoviedbDatasource extends MoviesDatasource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX',
    }
  ));

  List<MovieEntity> _jsonToMovies ( Map<String,dynamic> json) {

    final movieDbResponse = MovieDbResponse.fromJson(json);
    final List<MovieEntity> movies = movieDbResponse.results
    .where((movieDB) => movieDB.posterPath != 'no-poster')
    .map(
      (movieDB) => MovieMapper.movieDBToEntity(movieDB)
    ).toList();
    return movies;
  }

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
      queryParameters: {
        'page': page,
      }
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) async{

    final response = await dio.get('/movie/popular', 
      queryParameters: {
        'page': page,
      }
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', 
      queryParameters: {
        'page': page,
      }
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', 
      queryParameters: {
        'page': page,
      }
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<MovieEntity> getMovieByID(String id) async {
    final response = await dio.get('/movie/$id');
    if ( response.statusCode != 200 ) throw Exception('Movie with id: $id not found');

    final movieDetails = MovieDetailsModel.fromJson(response.data);
    final MovieEntity movie = MovieMapper.movieDetailToEntity(movieDetails);
    return movie;
  }

}