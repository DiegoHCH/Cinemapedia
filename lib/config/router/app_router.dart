import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0', 
  routes: [
    GoRoute(
        path: '/home/:view',
        name: HomeScreen.name,
        builder: (context, state) {
          int pageIndex = int.parse(state.params['view'] ?? '0');
          if( pageIndex > 2 || pageIndex < 0) {
            pageIndex = 0;
          }
          return  HomeScreen(pageIndex: pageIndex,);
        },
        routes: [
          GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieID = state.params['id'] ?? 'no-id';
                return MovieScreen(movieId: movieID);
              }),
        ]),

    GoRoute(
      path: '/',
      redirect: ( _ , __ ) => '/home/0',
    )
]);
