import 'package:dartz/dartz.dart';
import 'package:ombd/core/error/exception.dart';
import 'package:ombd/core/network/network_info.dart';
import 'package:ombd/features/movies/data/data_souce/movies_remote_data_source.dart';
import 'package:ombd/features/movies/data/models/request/movies_parameter_model.dart';
import 'package:ombd/features/movies/data/models/response/movies_response_model.dart';
import 'package:ombd/features/movies/domain/repository/movies_repo.dart';

class MoviesRepoImplementation extends MoviesRepo {
  final MoviesRemoteDataSource moviesDataSource;
  final NetworkInfo networkInfo;

  MoviesRepoImplementation(
      {required this.moviesDataSource, required this.networkInfo});

  @override
  Future<Either<Exception, MoviesResponseModel>> getMovieDetails(
      MoviesParameterModel moviesParameterModel) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await moviesDataSource.getMovieDetails(moviesParameterModel);

        return Right(MoviesResponseModel.fromJson(response));
      } on ServerException catch (exception) {
        return Left(ServerException(dioError: exception.dioError));
      }
    } else {
      return Left(NoInternetException(message: "no_internet_connection"));
    }
  }
}
