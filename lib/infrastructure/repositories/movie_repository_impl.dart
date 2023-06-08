

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

import '../../domain/datasources/movies_datasources.dart';

class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource); 

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }
  
  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
  
  @override
  Future<MovieEntity> getMovieByID(String id) {
    return datasource.getMovieByID(id);
  }
  
  @override
  Future<List<MovieEntity>> serachMovies(String query) {
    return datasource.serachMovies(query);
  }

}