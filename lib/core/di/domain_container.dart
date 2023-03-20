import 'package:ombd/features/movies/data/repository_impl/movies_repo_impl.dart';
import 'package:ombd/features/movies/domain/repository/movies_repo.dart';

import 'injection_container.dart';

Future<void> initDomainDI() async {
  // REPOSITORIES
  serviceLocator.registerLazySingleton<MoviesRepo>(
    () => MoviesRepoImplementation(
      networkInfo: serviceLocator(),
      moviesDataSource: serviceLocator(),
    ),
  );
}
