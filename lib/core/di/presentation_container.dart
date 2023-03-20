import 'package:ombd/features/movies/presentation/cubit/movies_cubit.dart';

import 'injection_container.dart';

Future<void> initPresentationDI() async {
  // BLOC
  serviceLocator.registerFactory<MoviesCubit>(
    () => MoviesCubit(
      moviesRepo: serviceLocator(),
    ),
  );
}
