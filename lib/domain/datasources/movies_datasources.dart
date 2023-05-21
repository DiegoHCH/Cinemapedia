

import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MoviesDatasource {

  Future<List<MovieEntity>>getNowPlaying({ int page = 1 });

  Future<List<MovieEntity>>getPopular({ int page = 1 });


}