


import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier,Map<int, MovieEntity>>((ref) {
  final localStorageRepository = ref.watch(localStorageProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, MovieEntity>> {

  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository
  }): super({});

  Future<List<MovieEntity>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final moviesMap = <int, MovieEntity>{};
    for (final movie in movies) {
      moviesMap[movie.id] = movie;
    }

    state = { ...state, ...moviesMap };

    return movies;
  }

  Future<void> toggleFavorite( MovieEntity movie )  async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if( isMovieInFavorites ) {
      state.remove(movie.id);
      state = { ...state };
    } else {
      state = { ...state, movie.id: movie};
    }
  }

}