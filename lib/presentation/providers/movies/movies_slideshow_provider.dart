import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';



final moviesSlideshowProvider = Provider<List<MovieEntity>>((ref) {

  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0,6);

});