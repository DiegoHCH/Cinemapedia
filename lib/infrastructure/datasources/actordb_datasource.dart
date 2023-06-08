

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credistdb_response.dart';
import 'package:dio/dio.dart';

class ActordbDatasource extends ActorsDatasource {


  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX',
    }
  ));

  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) async{

    final response = await dio.get('/movie/$movieId/credits');
    final creditsDbResponse = CreditsDbResponse.fromJson(response.data);
    final List<ActorEntity> actors = creditsDbResponse.cast.map((cast) =>
      ActorMapper.castToEntity(cast)
    ,).toList();

    return actors;
  }

}