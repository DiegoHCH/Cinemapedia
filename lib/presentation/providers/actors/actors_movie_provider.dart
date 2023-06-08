import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<ActorEntity>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});





typedef GetActorsCallback = Future<List<ActorEntity>>Function(String movieID);
                   
class ActorsByMovieNotifier extends StateNotifier<Map<String,List<ActorEntity>>> {

  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}): super({});

  Future<void> loadActors(String movieID) async {

    if( state[movieID] != null ) return;

    final List<ActorEntity> actors = await getActors( movieID );

    state = { ...state, movieID: actors};
  }
}