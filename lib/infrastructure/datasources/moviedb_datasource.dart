
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
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

}