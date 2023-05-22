

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, MovieEntity>>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return MovieMapNotifier(getMovie: moviesRepository.getMovieByID);
});





typedef GetMovieCallback = Future<MovieEntity>Function(String movieID);

class MovieMapNotifier extends StateNotifier<Map<String,MovieEntity>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}): super({});

  Future<void> loadMovie(String movieID) async {

    if( state[movieID] != null ) return;

    final movie = await getMovie( movieID );

    state = { ...state, movieID: movie};
  }
}