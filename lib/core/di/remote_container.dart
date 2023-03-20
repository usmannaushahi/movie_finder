import 'package:ombd/features/movies/data/data_souce/movies_remote_data_source.dart';

import 'injection_container.dart';

Future<void> initRemoteDI() async {
  // DATA SOURCES
  serviceLocator.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(networkClient: serviceLocator()));
}
