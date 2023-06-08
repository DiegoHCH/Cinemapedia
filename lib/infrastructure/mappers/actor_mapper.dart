

import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credistdb_response.dart';

class ActorMapper {

    static ActorEntity castToEntity( Cast cast) => 
      ActorEntity(
        id: cast.id, 
        name: cast.name, 
        profilePath: cast.profilePath != null 
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://www.circumcisionpro.co.uk/wp-content/uploads/2021/05/avatar-profile-picture.jpg',
        character: cast.character
      );

}