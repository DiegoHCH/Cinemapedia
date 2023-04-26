import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
  
  final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlaying;
  
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

typedef MovieCallback = Future<List<MovieEntity>> Function({int page});

class MoviesNotifier extends StateNotifier<List<MovieEntity>> {

  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

  Future<void> loadNetxPage() async {
    currentPage++;
    
    final List<MovieEntity> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }

}