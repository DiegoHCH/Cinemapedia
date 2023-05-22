import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {

  static MovieEntity movieDBToEntity(MovieMovieDB movieDB) => MovieEntity(
      adult: movieDB.adult,
      backdropPath: (movieDB.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
        : 'https://studiolegalelisi.it/wp-content/uploads/2021/03/errore-404-1200x514.jpg',
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: (movieDB.posterPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
        : 'no-poster',
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount
  );

  static MovieEntity movieDetailToEntity(MovieDetailsModel movie) => MovieEntity(
    adult: movie.adult,
      backdropPath: (movie.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
        : 'https://studiolegalelisi.it/wp-content/uploads/2021/03/errore-404-1200x514.jpg',
      genreIds: movie.genres.map((e) => e.name).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: (movie.posterPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
        : 'https://studiolegalelisi.it/wp-content/uploads/2021/03/errore-404-1200x514.jpg',
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount
  );

}
